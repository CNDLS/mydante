require "#{Rails.root}/app/helpers/gui_helper.rb"

include GuiHelper

MyDante::Application.configure do
  config.ui = YAML::load(File.open("#{Rails.root}/config/ui.yml"))
end