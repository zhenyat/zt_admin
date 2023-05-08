# frozen_string_literal: true
################################################################################
#   clone.rb
#
#   Clones generic files to the App
#
#   26.01.2017  ZT
#   12.04.2017  1.2.0   Workaround *vendor* *assets* for RoR 5.1.x
#               1.2.1   Bugs fixed
#   22.07.2020  2.0.0   Updated for RoR 6
#   05.08.2020  2.4.0   Working version: Rails + Webpack
#   05.11.2020          Samples migration added
#   15.11.2020  2.21.0  bug fixed for images_handling.rb copying      
#   16.12.20202 3.0.0   seedbank handling
#   20.12.2020  3.4.0   positionable
#   26.12.2020  3.7.0   heritable
#   20.06.2021  3.13.0  Bootstrap 5 
#   13.11.2021  3.15.0  UUID generation
#   10.01.2022  3.23.0  generic test_helper.rb
#   20.01.2022  3.25.0  Bug fixed
#   15.03.2022  4.0.0   Ruby 3.1.1 / Rails 7.0.2.3
################################################################################
module ZtAdmin

  # Creates a directory for the App
  def self.create_dir dirname
    action_report dirname
    unless File.exist?  "#{AppRoot}/#{dirname}"
      FileUtils.mkdir_p "#{AppRoot}/#{dirname}"
    end
  end

  begin
    ### *root* directory  ###
    puts colored(GREY, "#{TAB}invoke     Application root directory")

    FileUtils.cp "#{generic}/gitignore", "#{AppRoot}/.gitignore"
    action_report ".gitignore"

    ### *config* directory   ###
    action_report "config"

    # File: config/application.rb
    fin  = File.open "#{config}/application.rb", "r"
    fout = File.open "#{AppRoot}/config/application.rb", "w"

    fin.each_line do |line|
      if line =~ /module Dummy/ then
        new_line = "module #{AppName}"
        fout.puts new_line            # Replace the line with *Dummy* App Name
      else
        fout.puts line                # Just copy a line
      end
    end
    fin.close
    fout.close
    action_report "config/application.rb"

    unless File.exist? "#{AppRoot}/config/routes_original.rb"
      action_report "config/routes_original.rb"
      FileUtils.mv "#{AppRoot}/config/routes.rb", "#{AppRoot}/config/routes_original.rb"
    end

    FileUtils.cp "#{config}/routes.rb", "#{AppRoot}/config"
    action_report "config/routes.rb"

    # zt_config directory
    create_dir  "config/zt_config"
    FileUtils.cp_r "#{config}/zt_config", "#{AppRoot}/config"

    # initializers directory
    action_report "config/initializers"

    action_report "config/initializers/git_info.rb"
    FileUtils.cp "#{config}/initializers/git_info.rb", "#{AppRoot}/config/initializers"

    action_report "config/initializers/zt_load.rb"
    FileUtils.cp "#{config}/initializers/zt_load.rb", "#{AppRoot}/config/initializers"

    if $uuid
      action_report "config/initializers/generators.rb"
      FileUtils.cp "#{config}/initializers/generators.rb", "#{AppRoot}/config/initializers"
    end

    ###   Locales
    # Directory: config/locales/defaults
    create_dir "config/locales/defaults"
    FileUtils.cp_r "#{config}/locales/defaults", "#{AppRoot}/config/locales"

    # Directory: config/locales/models
    create_dir "config/locales/models"
    FileUtils.cp_r "#{config}/locales/models", "#{AppRoot}/config/locales"

    # Directory: config/locales/views
    create_dir "config/locales/views"
    FileUtils.cp_r "#{config}/locales/views", "#{AppRoot}/config/locales"

    # Simple Form locales
    action_report "config/locales"
    FileUtils.cp "#{config}/locales/simple_form.en.yml", "#{AppRoot}/config/locales"
    FileUtils.cp "#{config}/locales/simple_form.ru.yml", "#{AppRoot}/config/locales"

    if File.exist? "#{AppRoot}/config/locales/en.yml"
      FileUtils.rm_f "#{AppRoot}/config/locales/en.yml"
      puts colored(RED,  "#{TAB}remove     ")  + "config/locales/en.yml"
    end

    ### Get generic files in the *lib* directory
    action_report "lib"

    action_report "lib/templates"
    create_dir "lib/templates"
    FileUtils.cp_r "#{lib}/templates", "#{AppRoot}/lib"

    # Remove either *erb* or *haml* templates
    if `gem list -i haml-rails` == "true\n"
      action_report "lib/template/haml"
      FileUtils.rm_rf "#{AppRoot}/lib/templates/erb"
    else
      action_report "lib/template/erb"
      FileUtils.rm_rf "#{AppRoot}/lib/templates/haml"
    end

    ####    db    ####
    action_report "db/seeds/"
    create_dir "db/seeds"
    FileUtils.cp "#{db}/seeds/user.seeds.rb", "#{AppRoot}/db/seeds"
    FileUtils.cp "#{db}/seeds/sample.seeds.rb", "#{AppRoot}/db/seeds"

    ### Get generic files in the *migrate* directory
    create_dir "db/migrate"
    current_dt = Time.now
    timestamp  = current_dt.strftime("%Y%m%d") + (current_dt.to_i/10000).to_s

    if $uuid
      action_report "db/migrate/#{timestamp}_enable_uuid.rb"
      FileUtils.cp "#{db}/migrate/TIMESTAMP_enable_uuid.rb", "#{AppRoot}/db/migrate/#{timestamp}_enable_uuid.rb"
      users_migration_file   = "#{db}/migrate/TIMESTAMP_create_users_uuid.rb"
      samples_migration_file = "#{db}/migrate/TIMESTAMP_create_samples_uuid.rb"
    else
      users_migration_file   = "#{db}/migrate/TIMESTAMP_create_users.rb"
      samples_migration_file = "#{db}/migrate/TIMESTAMP_create_samples.rb"
    end

    timestamp  = current_dt.strftime("%Y%m%d") + (current_dt.to_i/10000 + 2).to_s
    action_report "db/migrate/#{timestamp}_create_users.rb"
    FileUtils.cp users_migration_file, "#{AppRoot}/db/migrate/#{timestamp}_create_users.rb"

    timestamp  = current_dt.strftime("%Y%m%d") + (current_dt.to_i/10000 + 4).to_s
    action_report "db/migrate/#{timestamp}_create_samples.rb"
    FileUtils.cp samples_migration_file, "#{AppRoot}/db/migrate/#{timestamp}_create_samples.rb"

    ####    App   ####

    ### Get generic files in the *assets* directory
    action_report "app/assets/images"
    FileUtils.cp_r "#{assets}/images", "#{AppRoot}/app/assets"

    ### Get generic files in the *Models* directory
    action_report "app/models"

    action_report "app/models/user.rb"
    FileUtils.cp "#{models}/user.rb", "#{AppRoot}/app/models"
    action_report "app/models/sample.rb"
    FileUtils.cp "#{models}/sample.rb", "#{AppRoot}/app/models"

    action_report "app/models/concerns/avatarable.rb"
    FileUtils.cp "#{models}/concerns/avatarable.rb", "#{AppRoot}/app/models/concerns"

    action_report "app/models/concerns/images_handleable.rb"
    FileUtils.cp "#{models}/concerns/images_handleable.rb", "#{AppRoot}/app/models/concerns"

    action_report "app/models/concerns/heritable.rb"
    FileUtils.cp "#{models}/concerns/heritable.rb", "#{AppRoot}/app/models/concerns"

    action_report "app/models/concerns/positionable.rb"
    FileUtils.cp "#{models}/concerns/positionable.rb", "#{AppRoot}/app/models/concerns"

    action_report "app/models/concerns/emailable.rb"
    FileUtils.cp "#{models}/concerns/emailable.rb", "#{AppRoot}/app/models/concerns"

    ### Get generic files in the *Controllers* directory
    action_report "app/controllers"

    action_report "app/controllers/admin"
    create_dir "app/controllers/admin"

    action_report "app/controllers/admin/base_controller.rb"
    FileUtils.cp "#{controllers}/admin/base_controller.rb", "#{AppRoot}/app/controllers/admin"

    action_report "app/controllers/admin/panel_controller.rb"
    FileUtils.cp "#{controllers}/admin/panel_controller.rb", "#{AppRoot}/app/controllers/admin"

    action_report "app/controllers/admin/samples_controller.rb"
    FileUtils.cp "#{controllers}/admin/samples_controller.rb", "#{AppRoot}/app/controllers/admin"

    action_report "app/controllers/admin/users_controller.rb"
    FileUtils.cp "#{controllers}/admin/users_controller.rb", "#{AppRoot}/app/controllers/admin"

    action_report "app/controllers/concerns"
    FileUtils.cp_r "#{controllers}/concerns", "#{AppRoot}/app/controllers"

    action_report "app/controllers/application_controller.rb"
    FileUtils.cp "#{controllers}/application_controller.rb", "#{AppRoot}/app/controllers"

    action_report "app/controllers/sessions_controller.rb"
    FileUtils.cp "#{controllers}/sessions_controller.rb", "#{AppRoot}/app/controllers"

    action_report "app/controllers/pages_controller.rb"
    FileUtils.cp "#{controllers}/pages_controller.rb", "#{AppRoot}/app/controllers"

    ### Get generic files in the *helpers* directory
    action_report "app/helpers"

    action_report "app/helpers/admin"
    create_dir "app/helpers/admin"
    FileUtils.cp_r "#{helpers}/admin", "#{AppRoot}/app/helpers"

    action_report "app/helpers/application_helper.rb"
    FileUtils.cp "#{helpers}/application_helper.rb", "#{AppRoot}/app/helpers"

    action_report "app/helpers/sessions_helper.rb"
    FileUtils.cp "#{helpers}/sessions_helper.rb", "#{AppRoot}/app/helpers"

    ### Get generic files in the *javascript* directory
    action_report "app/javascript"

    if ZtAdmin::VERSION[0..3] >= '4'
      action_report "app/javascript/application.js"
      FileUtils.cp "#{javascript}/application.js", "#{AppRoot}/app/javascript"
    else
      action_report "app/javascript/packs/application.js"
      if ZtAdmin::VERSION[0..3] == '3.12'
        FileUtils.cp "#{javascript}/packs/application.B4.js", "#{AppRoot}/app/javascript/packs/application.js"
      else
        FileUtils.cp "#{javascript}/packs/application.js", "#{AppRoot}/app/javascript/packs"
      end
      action_report "app/javascript/stylesheets"
      FileUtils.cp_r "#{javascript}/stylesheets", "#{AppRoot}/app/javascript/"
    end
    
    ### Get generic files in the *policies* directory
    action_report "app/policies"

    action_report "app/policies/panel_policy.rb"
    FileUtils.cp "#{policies}/panel_policy.rb", "#{AppRoot}/app/policies"

    action_report "app/policies/sample_policy.rb"
    FileUtils.cp "#{policies}/sample_policy.rb", "#{AppRoot}/app/policies"

    action_report "app/policies/user_policy.rb"
    FileUtils.cp "#{policies}/user_policy.rb", "#{AppRoot}/app/policies"

    ### Get generic files in the *views* directory
    action_report "app/views"

    action_report "app/views/layouts"
    FileUtils.cp_r "#{views}/layouts", "#{AppRoot}/app/views"

    # Update app/views/layouts/application.rb (App name)
    action_report "app/views/layouts/application.html.erb"
    fin  = File.open "#{views}/layouts/application.html.erb", "r"
    fout = File.open "#{AppRoot}/app/views/layouts/application.html.erb", "w"

    fin.each_line do |line|
      if line =~ /Dummy/ then
        new_line = "<title>#{AppName}</title>"
        fout.puts new_line                # Replace the line with Dummy App Name
      else
        fout.puts line                    # Just copy a line
      end
    end
    fin.close
    fout.close

    # Directory *sessions*
    create_dir "app/views/sessions"
    FileUtils.cp_r "#{views}/sessions", "#{AppRoot}/app/views/"

    # Directory *pages*
    create_dir "app/views/pages"
    FileUtils.cp_r "#{views}/pages", "#{AppRoot}/app/views/"

    # Directory *shared*
    create_dir "app/views/shared"
    FileUtils.cp_r "#{views}/shared", "#{AppRoot}/app/views/"
    
    # Directory *admin*
    create_dir "app/views/admin/"
    FileUtils.cp_r "#{views}/admin", "#{AppRoot}/app/views/"

    ### Get generic files in the *test* directory
    if Dir.exist?  "#{AppRoot}/test"
      action_report "test/test_helper.rb"
      FileUtils.cp "#{test}/test_helper.rb", "#{AppRoot}/test/test_helper.rb"
    end

    puts colored(RED, "\n#{TAB}Workaround: remove default version of gem 'psych'!")
    puts colored(RED, "#{TAB*2}e.g.:  rm ~/.rubies/ruby-3.2.2/lib/ruby/gems/3.2.0/specifications/default/psych-5.0.1.gemspec")
    puts colored(MAGENTA, "\n#{TAB}Run commands now (to create db table 'users' & 'samples):")
    puts colored(MAGENTA, "#{TAB*2}bin/rails db:create")
    puts colored(MAGENTA, "#{TAB*2}bin/rails action_text:install")
    puts colored(MAGENTA, "#{TAB*2}bin/rails db:migrate")
    puts colored(MAGENTA, "#{TAB*2}bin/rails db:seed")
    puts colored(GRAY, "\n============================")
    puts colored(BLUE, "#{TAB}To generate API component run:")
    puts colored(BLUE, "#{TAB*2}bin/rails g devise:install")
    puts colored(BLUE, "#{TAB*2}bin/rails g devise_token_auth:install Account auth")
    puts colored(BLUE, "#{TAB*2}bin/rails db:migrate")
    puts colored(BLUE, "#{TAB*2}zt_admin a[pi]")
    puts colored(GRAY, "\n============================\n")

  rescue Exception => error
    puts colored(RED, "\nACHTUNG! Something went wrong during cloning process...")
    puts colored(RED, error.message)
  end
end
