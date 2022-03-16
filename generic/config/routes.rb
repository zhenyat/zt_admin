################################################################################
#   29.03.2018  Bug fixed for logout error (is it since Rails 5.2?):
#               No route matches [GET] "/ru/logout" 
#               Solution: *get* instead of *delete*  - has been canceled (see below)
#               Later: The bug is vanishing if to use *jquery_ujs* - MUST BE!
#   01.11.2020  Active Storage added for redirection
#   02.11.2020  DRY code
#   07.12.2020  Fixing Error: No route matches [GET] “/logout”
#   16.03.2022  Rails 7
################################################################################
Rails.application.routes.draw do

  app_scope = MULTILINGUAL ? "/:locale" : "/"
  scope app_scope, locale: /#{I18n.available_locales.join("|")}/ do

    # Session resources
    get    'sessions/new'                                # sessions_new_path
    post   'login',  to: 'sessions#create'               # login_path  - creates new session (login)
    get    'logout', to: 'sessions#destroy', as: :logout # logout_path - destroys    session (log out)
  # delete 'logout', to: 'sessions#destroy', as: :logout # logout_path - deletes session (log out)

    namespace :admin do
      root 'panel#index'                                 # admin_root_path
      resources :users
      resources :samples
      # Add new admin resources before this line
    end

    root      'pages#home'                               # root_path
    get :demo, to: 'pages#demo', path: 'demo'
    resources  :samples
  end

  if MULTILINGUAL
    # Root route is directed to default locale
    root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root

    # All other routes without locales are directed to the same ones with locales
    #get "/*path", to: redirect("/#{I18n.default_locale}/%{path}", status: 302), constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false
  
    # Active Storage paths are excluded from the redirection process
    get "/*path", to: redirect("/#{I18n.default_locale}/%{path}", status: 302), constraints: {path: /(?!(rails\/active_storage|#{I18n.available_locales.join("|")})\/).*/}, format: false
  end
end
