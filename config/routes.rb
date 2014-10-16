TwitterDiversityReport::Application.routes.draw do
  
  get "reports/new" => 'reports#new', :as => "new_report"

  get "reports/:nickname" => 'reports#show', :as => "report"

  root :to => 'pages#welcome'
  
  get "users" => 'users#index', :as => "users"
  post "users" => 'users#create'
  get "users/:name/edit" => 'users#edit', :as => "edit_user"
  put "users/:name/edit" => 'users#update'
  get "welcome" => 'pages#welcome', :as => "welcome"
  
  get "optional" => 'pages#optional', :as => "optional"

  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect(users_path)
  match 'signout', to: 'sessions#destroy', :as => "signout"

end
