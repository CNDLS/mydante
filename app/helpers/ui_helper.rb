module UiHelper
  # classes for generating the UI from config files.
  
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


    def initialize(*args)
      raise ArgumentError, "You passed too many arguments!" if args.size > self.class.attrs.size
      # Loop through each arg, assigning it to the appropriate attribute (based on the order)
      args.each_with_index do |val, i|
        attr = self.class.attrs[i]
        instance_variable_set "@#{attr}", val
      end
    end
  end
  
    
  # ------
  
  class YAMLConfig
    include Attrs
    has_attrs
    
    
    def attr_hash
      hash = {}
      self.class.attrs.each { |var|
        hash[var] = self.send(var)
      }
      hash
    end
    
    
    def render(rendering_context, partial_name)
      # default is to render an application-level partial for each ui section.
      rendering_context.render :partial => "application/#{partial_name}", :locals => attr_hash
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
                partial_name = config.class.name.split('::').last.underscore
                config.render(rendering_context, partial_name)
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
    
    def items
      # if our items member is a factory, use it to generate items.
      if @items.is_a? MenuItemFactory
      else
        @items
      end
    end
  end
  
  
  class MenuItemFactory < YAMLConfig
  end
  
  
  class MenuItemsFromFilesFactory < MenuItemFactory
    has_attrs :base_filename, :directory
    attr_accessor :files
    
    def files
      # look into directory
      # make a MenuItem for each file that:
      # - starts with base_filename 
      # - counts upward from 1, or has no number appending onto base_filename.
    end
  end
  
end


module UIHelper
  include UiHelper
end