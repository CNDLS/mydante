if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source 'http://rubygems.org'

gem 'rails', '~> 3.2.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# gemfile initially composed on 10/25/11 bg.
gem 'jquery-rails', '~> 2.0.1'  #'~> 1.0.16'

# gem 'aws-s3' #, '~> 0.6.2'
gem 'rspec-rails', '>= 2.8.1', :group => [:development, :test]
gem 'activeadmin', '~> 0.4.3'
gem 'acts-as-taggable-on', '~> 2.2.2'
gem 'cancan', '~> 1.6.7'
gem 'gravatar', '~> 1.0'
gem 'haml', '~> 3.1.4'
gem 'haml-rails', '~> 0.3.4'
gem 'kaminari', '~> 0.13.0'
gem 'json', '1.6.5'
gem "mysql2", "~> 0.3.11"
gem "ruby-mysql", "~> 2.9.6"
gem "nokogiri", "~> 1.5.2"
gem 'omniauth', '~> 1.1.0'
gem "omniauth-ldap", "~> 1.0.2"
gem 'paperclip', '~> 2.7.0'
gem 'tilt', '~> 1.3.3'
gem 'validates_email_format_of', '~> 1.5.3'

gem 'therubyracer', '0.9.10'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.4'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
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


gem 'devise', '2.0.4' #'1.4.7' #  git: "https://github.com/plataformatec/devise.git", branch: "master" # '~> 1.4.9'
