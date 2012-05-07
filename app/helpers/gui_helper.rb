require 'roman'

module GuiHelper
  # classes for generating the Graphical User Interface from config files.
  # NOTE: can't store rendering_context, as it seems to change during the course of rendering and becomes invalid. just passing it to methods.
  
  
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
    attr_accessor :name, :attrs
    
    
    def attr_hash
      hash = {}
      self.class.attrs.each { |var|
        hash[var] = self.send(var)
      }
      hash
    end
    
    # this class should also eventually have a method that refers back to the source file
    # for whatever YAML config supplied all the attrs.
    
  end
  
  
  class UI < YAMLConfig
    include Attrs
    has_attrs :header, :footer, :page_header, :page_footer, :navigation, :contents, :sidebars, :menus, :widgets
    cattr_accessor :rendering_context
    
    def self.config_from_class(config)
      # NOTE naming convention for config classes, so they match UI attrs.
      config.class.name.split('::').last.underscore
    end
    
    
    def build(*args)
      UI.rendering_context = args.shift
      args = attrs if args.empty?
      
      args.each do |ui_section|
        ui_section_config = MyDante::Application.config.ui.send(ui_section)
        ui_section_config = [ui_section_config] unless ui_section_config.is_a? Array
        
        ui_section_config.each do |config|
          # get any config variables
          begin
            UI.rendering_context.content_for ui_section do
              if (config.is_a? UIElement)
                config.name = self.class.config_from_class(config)
                config.render
              else
                partial_name = ui_section.to_s
                UI.rendering_context.render(partial_name)
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
  

  class UIElement < YAMLConfig
    
    def render(partial_name=nil)
      partial_name = self.name if partial_name.nil?
      # try rendering an <action>_<partial_name> partial for the current controller.
      begin
        controller_name = UI.rendering_context.controller.controller_name
        action_name = rendering_context.controller.action_name
        UI.rendering_context.render :partial => "#{controller_name}/#{action_name}_#{partial_name}", :locals => attr_hash
      rescue
        # default is to render an application-level partial for each ui section.
        UI.rendering_context.render :partial => "application/#{partial_name}", :locals => attr_hash
      end
    end
    
    
    def label
      name
    end
    
    
    def id
      name.underscore
    end
  end


  class Menubar < UIElement
    include Attrs
    has_attrs :name, :menus
  end
  
  
  class Menu < UIElement
    include Attrs
    has_attrs :name, :items
    
    def get_items
      @items.collect do |item|
        case item
        when GuiHelper::MenuItem
          item
        when GuiHelper::MenuItemFactory  
          item.get_items
        else # hash
          GuiHelper::MenuItem.new(item.fetch("name", nil), item.fetch("href", nil), item.fetch("path", nil))
        end
      end.flatten.compact
    end
  end
  
  
  class MenuItemFactory < UIElement
    include Attrs
    has_attrs :item_class
    
    def initialize(item_class="MenuItem")
      item_class = item_class
    end
    
    def item_class
      @item_class = @item_class.constantize if @item_class.is_a? String
      @item_class
    end
  end
  
  
  class MenuItemsFromFilesFactory < MenuItemFactory
    include Attrs
    has_attrs :base_filename, :directory
    attr_accessor :files
    
    def initialize(base_filename, directory, item_class)
      super(item_class)
      base_filename = base_filename
      directory = directory
    end
    
    def get_items
      # look into directory
      # make a MenuItem for each file that:
      # - starts with base_filename 
      # - counts upward from 1, or has no number appending onto base_filename.
      local_directory_path = Rails.root + "app/assets"+ @directory
      filenames = Dir.open(local_directory_path).select do |item_filename|
        item_filename.include?(@base_filename)
      end.compact
      filenames.collect do |filename|
        item_from_filename(filename)
      end
    end
    
    def item_from_filename(filename)
      # look to see if we have an Asset with this file path. if so, make a nice url to it.
      # otherwise, point to the file (maybe do some checking of permissions on the directory and/or file?)
      item_name = File.basename(filename, ".*").sub(@base_filename, "")
      media_path = UI.rendering_context.media_path(@directory +"/"+ filename)
      item_class.new(item_name, media_path)
    end
  end
  
  
  class MenuItem < UIElement
    include Attrs
    has_attrs :name, :href, :path
    
    def initialize(name, href, path=nil)
      @name = name
      @href = href
      @path = path
    end
    
    def href
      @href ||= UI.rendering_context.send(:eval, @path) unless @path.nil?
      @href
    end
    
    def render
      begin
        UI.rendering_context.link_to label, href
      rescue
        "Unavailable"
      end
    end
    
  end
  
  
  class CantoMenuItem < MenuItem
    def label
      canto_nbr = super.sub("_", "").to_i
      "Canto #{canto_nbr.roman}"
    end
  end
end