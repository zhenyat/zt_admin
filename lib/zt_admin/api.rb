################################################################################
#   api.rb
#
#   Clones generic API files
#
#   16.12.2020  ZT
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
    ### *config* directory   ###
    action_report "config"

    # File: config/routes.rb: with API
    unless File.exist? "#{AppRoot}/config/routes_backup.rb"
      action_report "config/routes_backup.rb"
      FileUtils.mv "#{AppRoot}/config/routes.rb", "#{AppRoot}/config/routes_backup.rb"
    end

    action_report "config/routes.rb"
    FileUtils.cp_r "#{generic_api}/config/routes.rb", "#{AppRoot}/config"

    ### Initializers
    action_report "config/initializers"

    action_report "config/initializers/cors.rb"
    FileUtils.cp "#{generic_api}/config/initializers/cors.rb", "#{AppRoot}/config/initializers"

    action_report "config/initializers/devise.rb"
    FileUtils.cp "#{generic_api}/config/initializers/devise.rb", "#{AppRoot}/config/initializers"

    action_report "config/initializers/devise_token_auth.rb"
    FileUtils.cp "#{generic_api}/config/initializers/devise_token_auth.rb", "#{AppRoot}/config/initializers"

    ###   Locales
    action_report "config/locales/devise.ru.yml"
    FileUtils.cp "#{generic_api}/config/locales/devise.ru.yml", "#{AppRoot}/config/locales/"

    action_report "config/locales/devise.ru.yml"
    FileUtils.cp "#{generic_api}/config/locales/devise.ru.yml", "#{AppRoot}/config/locales/views"

    action_report "config/locales/models"

    action_report "config/locales/models/en.yml"
    FileUtils.cp "#{generic_api}/config/locales/models/en.yml", "#{AppRoot}/config/locales/models"
    action_report "config/locales/models/ru.yml"
    FileUtils.cp "#{generic_api}/config/locales/models/ru.yml", "#{AppRoot}/config/locales/models"


    ####    db    ####
    action_report "db/seeds/account.seeds.rb"
    FileUtils.cp "#{generic_api}/db/seeds/account.seeds.rb", "#{AppRoot}/db/seeds"
 
    ####    App   ####

    ### Get generic API files in the *Controllers* directory
    action_report "app/controllers/api"
    create_dir "app/controllers/api/v1"
    action_report "app/controllers/api/v1/samples_controller.rb"
    FileUtils.cp "#{generic_api}/app/controllers/api/v1/samples_controller.rb", "#{AppRoot}/app/controllers/api/v1"

    action_report "app/controllers/api/api_controller.rb"
    FileUtils.cp "#{generic_api}/app/controllers/api/api_controller.rb", "#{AppRoot}/app/controllers/api"

    action_report "app/controllers/admin/accounts_controller.rb"
    FileUtils.cp "#{generic_api}/app/controllers/admin/accounts_controller.rb", "#{AppRoot}/app/controllers/admin"

    ### Get generic API files in the *Policies* directory
    action_report "app/policies"
    action_report "app/policies/account_policy.rb"
    FileUtils.cp "#{generic_api}/app/policies/account_policy.rb", "#{AppRoot}/app/policies"

    ### Get generic API files in the *Views* directory
    action_report "app/views/admin/accounts"
    create_dir    "app/views/admin/accounts"
    
    action_report "app/views/admin/accounts/index.html.erb"
    FileUtils.cp "#{generic_api}/app/views/admin/accounts/index.html.erb", "#{AppRoot}/app/views/admin/accounts"

    action_report "app/views/admin/accounts/show.html.erb"
    FileUtils.cp "#{generic_api}/app/views/admin/accounts/show.html.erb",  "#{AppRoot}/app/views/admin/accounts"

    action_report "app/views/admin/shared"
    action_report "app/views/admin/shared/_admin_top_navigation.html.erb"
    FileUtils.cp "#{generic_api}/app/views/admin/shared/_admin_top_navigation.html.erb", "#{AppRoot}/app/views/admin/shared"

    puts colored(MAGENTA, "\n#{TAB}Run command now:")
    puts colored(MAGENTA, "#{TAB*2}bin/rails db:seed:account")

  rescue Exception => error
    puts colored(RED, "\nACHTUNG! Something went wrong during API cloning process...")
    puts colored(RED, error.message)
  end
end
