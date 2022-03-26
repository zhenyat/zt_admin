################################################################################
#   15.12.2020  ZT: API is included
################################################################################
Rails.application.routes.draw do
  mount_devise_token_auth_for 'Account', at: 'auth'
 
  app_scope = MULTILINGUAL ? "/:locale" : "/"
  scope app_scope, locale: /#{I18n.available_locales.join("|")}/ do

    # Session resources
    get    'sessions/new'                                # sessions_new_path
    post   'login',  to: 'sessions#create'               # login_path  - creates new session (login)
    # get  'logout', to: 'sessions#destroy', as: :logout # logout_path - destroys    session (log out)
    delete 'logout', to: 'sessions#destroy', as: :logout # logout_path - deletes session (log out)

    namespace :admin do
      root 'panel#index'                                 # admin_root_path
      resources :users
      resources :samples
      resources :accounts, only: [:index, :show]
      # Add new admin resources before this line
    end
  
    namespace :api do
      namespace :v1 do
        resources :samples
      end
    end
    root 'pages#home'   # root_path for BE 

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
