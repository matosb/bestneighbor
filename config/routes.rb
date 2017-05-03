Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get "/aide" => "pages#aide"
  get "/choix" => "pages#choix"
  get "/cgu" => "pages#cgu"

  get '/robots' => 'pages#robots'

  resources :listes
  post "/listes/:id" => "listes#takenby"

  resources :trajets
  post "/trajets/:id" => "trajets#takenby"

end
