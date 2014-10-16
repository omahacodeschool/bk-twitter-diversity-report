TwitterDiversityReport::Application.routes.draw do
  
  get "users" => 'users#index', :as => "users"
  get "users/:id/edit" => 'users#edit', :as => "edit_user"
  put "users/:id/edit" => 'users#update'
  get "welcome" => 'pages#welcome', :as => "welcome"

  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect(users_path)
  match 'signout', to: 'sessions#destroy', :as => "signout"

end
