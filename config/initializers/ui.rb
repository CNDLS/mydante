require "#{Rails.root}/app/helpers/gui_helper.rb"
require "#{Rails.root}/app/helpers/proust_gui_helper.rb"

Proust::Application.configure do
  config.ui = YAML::load(File.open("#{Rails.root}/config/ui.yml"))
end