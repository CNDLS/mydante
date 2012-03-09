source 'http://rubygems.org'

gem 'rails', '~> 3.1.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# gemfile initially composed on 10/25/11 bg.
gem 'jquery-rails', '~> 1.0.16'

gem 'aws-s3' #, '~> 0.6.2'
gem 'rspec-rails', '>= 2.6.1', :group => [:development, :test]
gem 'activeadmin' #, '~> 0.3.2'
gem 'acts-as-taggable-on', '~> 2.1.1'
gem 'cancan', '~> 1.6.7'
# temp due to bug in devise -- conflicting dependency on bcrypt with sass-rails.
gem 'devise', '1.4.7' #  git: "https://github.com/plataformatec/devise.git", branch: "master" # '~> 1.4.9'
gem 'gravatar', '~> 1.0'
gem 'haml', '~> 3.1.3'
gem 'haml-rails', '~> 0.3.4'
gem 'kaminari' #, '~> 0.12.4'
gem 'mysql', "~> 2.8.1"
gem 'omniauth', '~> 1.0.2'
gem "oa-oauth", :require => "omniauth/oauth"
gem "oa-enterprise", "~> 0.3.2"
gem "omniauth-shibboleth", "~> 1.0.4"
gem 'paperclip', '~> 2.7'
gem 'tilt', '~> 1.3.3'
gem 'validates_email_format_of', '~> 1.5.3'


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end


group :development do
  gem 'mongrel',  '1.2.0.pre2'
end


group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end


group :production do
    # useful for heroku deployments
    gem 'taps'
end
