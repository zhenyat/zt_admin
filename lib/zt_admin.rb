# frozen_string_literal: true
################################################################################
#   zt_admin.rb
#     Main Module to create / update / destroy directories and files
#
#   29.01.2017  ZT
#   14.12.2020  API is added
#   26.12.2020  gem 'ancestry'
#   20.06.2021  Bootstrap 5 - jQuery + @popperjs/core (v.13.0.0)
#   15.03.2022  ruby 3.1.1 / Rails 7.0.2.3
################################################################################
# require_relative "zt_admin/version"
require 'zt_admin/version'
require 'zt_admin/setpar'
require 'active_support/inflector'   # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
require 'zt_admin/methods_pool'
require 'zt_admin/command_parser'
require 'pp'
require 'active_support/dependencies/autoload'

module ZtAdmin
  class Error < StandardError; end
  
  options = OptparseCommand.parse(ARGV)
  get_names options
  
  
  if $mode == 'init'
    require 'zt_admin/init'     # Initial step

  elsif $mode == 'clone'        # Cloning step
    require 'zt_admin/clone'    # Copy Generic files

  elsif $mode == 'api'
    require 'zt_admin/api'      # Copy API Generic files

  elsif $mode == 'generate'     # Generate Admin directories and files

    if $model == "User"
      puts colored RED, "The model User has been already generated!"
      exit
    end

    get_attributes

    require 'zt_admin/model'          # Update Model
    require 'zt_admin/controller'     # Admin Controller
    require 'zt_admin/add_resource'   # Update config/routes.rb file
    require 'zt_admin/policy'         # Generate policy file

    create_views_path                 # Generate Admin Views for the Model
    require 'zt_admin/views/erb/view_index'
    require 'zt_admin/views/erb/view_show'
    require 'zt_admin/views/erb/view_instance'
    require 'zt_admin/views/erb/view_new'
    require 'zt_admin/views/erb/view_edit'
    require 'zt_admin/views/erb/view_form'

  else                                # Destroy Admin files and directories
    if $model == "User"
      puts colored RED, "The model User can't be destroyed!"
      exit
    end

    require 'zt_admin/destroy'         # Destroy files and directories
    require 'zt_admin/remove_resource' # Remove resource from config/routes.rb file
  end
  
  # Test sample
  class Sample
    def say_hello
      puts 'Hello from ZtAdmin! Just first test for ruby 3.1.1 / Rails 7.0.2.3'
    end
  end
end
