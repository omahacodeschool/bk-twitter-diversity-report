TwitterDiversityReport::Application.routes.draw do
  
  get 'users' => 'users#index', :as => "users"

  match 'auth/:provider/callback', to: 'sessions#create'

end
