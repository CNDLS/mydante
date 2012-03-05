module UiHelper
  # stores a number of classes useful for interacting with the UI.
  
  # from http://stackoverflow.com/questions/7844457/turning-constructor-arguments-into-instance-variables
  module Attrs
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        class << self
          attr_accessor :attrs
        end
      end
    end

    module ClassMethods
      # Define the attributes that each instance of the class should have
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
    # refers back to the source file for whatever YAML config supplied all the attrs.
    
    def to_hash
      hash = {}
      instance_variables.each {|var| hash[var.to_s.delete("@").to_sym] = instance_variable_get(var) }
      hash
    end
  end
  
  
  class UI < YAMLConfig
    include Attrs
    has_attrs :header, :footer, :navigation, :messages, :content_areas, :sidebars, :contextual_menus, :widgets
    attr_accessor :context
    
    def self.build(context)
      @context = context
      
      attrs.each do |ui_section|
        @context.content_for ui_section do
          
          ui_section_config = Proust::Application.config.ui.send(ui_section)
          ui_section_config = [ui_section_config] unless ui_section_config.is_a? Array
          
          ui_section_config.each do |config|
            # get any config variables
            begin
              if (config.is_a? YAMLConfig)
                attrs = config.to_hash
                ui_section_partial_name = config.class.name.split('::').last.underscore
              else
                attrs = {}
                ui_section_partial_name = ui_section
              end
            rescue
              ui_section_partial_name = ui_section
            end
          
            # render any applicable partial templates
            begin
              "aaaa"
              # @context.render :partial => "application/#{ui_section_partial_name}", :locals => attrs
            rescue ActionView::MissingTemplate => mte
              p "no partial template at application/#{ui_section_partial_name}"
            rescue Exception => e
              p e.inspect
            end
          end
          
        end
      end
    end
  end


  class Menubar < YAMLConfig
    include Attrs
    has_attrs :name, :menus
  end
  
  
  class Menu < YAMLConfig
    include Attrs
    has_attrs :name, :items
  end
  
  
  class MenuItemsFromFilesFactory < YAMLConfig
    include Attrs
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