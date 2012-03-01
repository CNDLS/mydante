require "#{Rails.root}/app/helpers/ui_helper.rb"

Proust::Application.configure do
  config.ui = YAML::load(File.open("#{Rails.root}/config/ui.yml"))
end