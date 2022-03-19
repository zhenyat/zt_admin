################################################################################
# require 'yaml'
# ZT_CONFIG = YAML.load(File.read(File.expand_path('../ZT_config.yml', __FILE__)))
# ZT_CONFIG = YAML.load_file("#{Rails.root}/config/zt_config.yml")
# puts ZT_CONFIG['zt_initializer']
#   or Sample 2:
# if File.exists?(File.expand_path('../application.yml', __FILE__))
#   config = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
#   config.merge! config.fetch(Rails.env, {})
#   config.each do |key, value|
#     ENV[key] ||= value.to_s unless value.kind_of? Hash
#   end
# end
#     NB! add application.yml to .gitignore
#
# 08.01.2022  ZT  Adopted for RoR 7
################################################################################
require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ground
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # ZT updates
    # config.multilingual         = false       # Alternative to MULTILINGUAL (used as: Rails.application.config.multilingual) 
    config.time_zone              = "Moscow"    # Default: UTC
    config.i18n.available_locales = %w(en ru)   # [:en, :de, :ru] - to be compared / investigated
    config.i18n.default_locale    = :en
    config.i18n.load_path        += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]  # YAML Multiple structure

    config.active_storage.replace_on_assign_to_many = true  # To be depricated in RoR 7.1
  end
end
