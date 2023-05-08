#####################################################################
#   Generic Gemfile for:
#
#   Ruby 3.1.1 / Rails 7.0.2.2
#   ESBuild, Bootstrap, Simple Form, enum_helper, solargraph, etc.
#   No: haml-rails, importmap-rails, bootstrap, sassc-rails
#
#   19.02.2022  ZT
#   19.04.2022  Ruby 3.1.2
#   08.05.2023  Ruby 3.2.2 / Rails 7.0.4.3
#####################################################################
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

gem "sprockets-rails"   # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "puma"              # Use the Puma web server [https://github.com/puma/puma]
gem "jsbundling-rails"  # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "cssbundling-rails" # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "turbo-rails"       # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "stimulus-rails"    # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "jbuilder"          # Build JSON APIs with ease [https://github.com/rails/jbuilder]

# gem "redis", "~> 4.0" # Use Redis adapter to run Action Cable in production
# gem "kredis"          # Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]

gem "bcrypt"            # Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "bootsnap",    require: false  # Reduces boot times through caching; required in config/boot.rb
gem "image_processing"  # Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]

############ ZT ############
gem 'sqlite3'
gem 'mysql2'

gem "pg"
# gem 'securerandom'  # For UUID
gem 'pg_search'     # https://mkdev.me/posts/kak-delat-full-text-poisk-v-rails-pri-pomoschi-postgresql

gem 'seed_dump'       # https://github.com/rroblak/seed_dump
gem 'seedbank'        # http://github.com/james2m/seedbank

gem 'foreman'
# gem 'ancestry'        # https://github.com/stefankroes/ancestry
gem 'pundit'          # https://github.com/elabs/pundit
# gem 'haml-rails'    # https://github.com/indirect/haml-rails

gem 'simple_form'     # https://github.com/plataformatec/simple_form
gem 'enum_help'       # MUST BE for simple form 
gem 'translate_enum'
gem 'countries'
gem 'solargraph'      # For VS Code

# gem 'rack-cors'
# gem 'devise'
# gem 'devise_token_auth'
#
# crono for jobs
# gem 'crono'
# gem 'daemons'
# gem 'sinatra', require: nil      # to run web-console for crono

# gem 'whenever', :require => false
# gem "simple_scheduler"

# Charts
# gem 'gon'
# gem 'fusioncharts-rails'
# gem 'chartkick'

# gem 'rest-client'                # https://github.com/rest-client/rest-client
#########################

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"   # Use console on exceptions pages [https://github.com/rails/web-console]
  # gem "rack-mini-profiler"    # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "spring"     # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end