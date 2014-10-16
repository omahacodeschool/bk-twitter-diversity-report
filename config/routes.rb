TwitterDiversityReport::Application.routes.draw do
  
  get "reports/new"

  get "reports/show"

  root :to => 'pages#welcome'
  
  get "users" => 'users#index', :as => "users"
  post "users" => 'users#create'
  get "users/:id/edit" => 'users#edit', :as => "edit_user" #took out id since user is "new"
  put "users/:id/edit" => 'users#update'
  get "welcome" => 'pages#welcome', :as => "welcome"
  
  get "optional" => 'pages#optional', :as => "optional"

  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect(users_path)
  match 'signout', to: 'sessions#destroy', :as => "signout"

end
