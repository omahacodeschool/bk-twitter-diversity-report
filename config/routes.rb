TwitterDiversityReport::Application.routes.draw do
  
  get "users" => 'users#index', :as => "users"
  get "users/new" => 'users#new', :as => "new_user"
  post "users" => 'users#create'

  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect(users_path)
  match 'signout', to: 'sessions#destroy', :as => "signout"

end
