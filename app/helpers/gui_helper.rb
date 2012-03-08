module GuiHelper
  # classes for generating the Graphical User Interface from config files.
  # NOTE: can't store rendering_context, as it seems to change during the course of rendering and becomes invalid. just passing it to methods.
  
  # monkey-patch YAML's object_maker, so we get initialize called.
  # def YAML.object_maker( obj_class, val )
  #    if Hash === val
  #        o = obj_class.allocate
  #        val.each_pair { |k,v|
  #            o.instance_variable_set("@#{k}", v)
  #        }
  #        o
  #    else
  #        raise YAML::Error, "Invalid object explicitly tagged !ruby/Object: " + val.inspect
  #    end
  # end
  # 
  
  module RenderingContext
    def within(rendering_context, &block)
      rendering_context.instance_eval(&block)
    end
  end
  
  
  # from http://stackoverflow.com/questions/7844457/turning-constructor-arguments-into-instance-variables
  module Attrs
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        # this syntax, because base.attr_accessor doesn't work: attr_accessor is private.
        class << self
          attr_accessor :attrs
        end
      end
    end

    module ClassMethods
      def has_attrs(*attrs)
        self.attrs = attrs
        attr_accessor *attrs
      end
    end
  end
  
    
  # ------
  
  class YAMLConfig
    include Attrs
    
    include RenderingContext
    
    attr_accessor :name, :attrs
    
    
    def attr_hash
      hash = {}
      self.class.attrs.each { |var|
        hash[var] = self.send(var)
      }
      hash
    end
    
    
    def render(rendering_context, partial_name=nil)
      partial_name = self.name if partial_name.nil?
      # try rendering an <action>_<partial_name> partial for the current controller.
      begin
        controller_name = rendering_context.controller.controller_name
        action_name = rendering_context.controller.action_name
        rendering_context.render :partial => "#{controller_name}/#{action_name}_#{partial_name}", :locals => attr_hash
      rescue
        # default is to render an application-level partial for each ui section.
        rendering_context.render :partial => "application/#{partial_name}", :locals => attr_hash
      end
    end
    
    # this class should also eventually have a method that refers back to the source file
    # for whatever YAML config supplied all the attrs.
    
  end
  
  
  class UI < YAMLConfig
    has_attrs :header, :footer, :page_header, :page_footer, :navigation, :contents, :sidebars, :menus, :widgets
    
    def build(*args)
      rendering_context = args.shift
      args = attrs if args.empty?
      
      args.each do |ui_section|
        ui_section_config = Proust::Application.config.ui.send(ui_section)
        ui_section_config = [ui_section_config] unless ui_section_config.is_a? Array
        
        ui_section_config.each do |config|
          # get any config variables
          begin
            rendering_context.content_for ui_section do
              if (config.is_a? YAMLConfig)
                config.name = config.class.name.split('::').last.underscore
                config.render(rendering_context)
              else
                partial_name = ui_section.to_s
                render(rendering_context, partial_name)
              end
            end
            
          rescue ActionView::MissingTemplate => mte
            p "no partial template at application/#{ui_section}"
            ""
          rescue Exception => e
            "#{ui_section} render error: #{e.message}"
            raise e
          end
          
        end
      end
    end
  end


  class Menubar < YAMLConfig
    has_attrs :name, :menus
  end
  
  
  class Menu < YAMLConfig
    has_attrs :name, :items
    
    def get_items(rendering_context)
      # if our items member is a factory, use it to generate items.
      @items.each_with_index do |item, i|
        if item.is_a? MenuItemFactory
          @items[i] = item.get_items(rendering_context)
        end
      end.flatten!
      @items
    end
    
    
    def render(rendering_context, partial_name=nil)
      menu_name = name
      menu_items = get_items(rendering_context)
      
      within rendering_context do
        capture_haml do
          
          # link to show the menu.
          haml_tag :li, { :id => "#{menu_name}_menu_btn", :class => "menu_btn" } do
            haml_concat link_to(menu_name, null_js)
          end
          
          # hidden div that holds the menu
          haml_tag :div, { :id => "#{menu_name}_menu", :class => "menu" } do
            menu_items.each do |item|
              haml_tag :li, { :id => "#{menu_name}_menu_item", :class => "menu_item" } do
                p item.inspect
                haml_concat link_to(item[:name], null_js)
              end
            end
          end
        end
      end
    end
  end
  
  
  class MenuItemFactory < YAMLConfig
  end
  
  
  class MenuItemsFromFilesFactory < MenuItemFactory
    has_attrs :base_filename, :directory
    attr_accessor :files
    
    def get_items(rendering_context)
      # look into directory
      # make a MenuItem for each file that:
      # - starts with base_filename 
      # - counts upward from 1, or has no number appending onto base_filename.
      local_directory_path = Rails.root + "app/"+ rendering_context.asset_path(directory).sub("/", "")
      file_names = Dir.open(local_directory_path).select do |page_filename|
        page_filename.include?(@base_filename)
      end
      file_names.collect do |file_name|
        { :name => file_name, :href => rendering_context.asset_path(directory + file_name) }
      end
    end
  end
  
end