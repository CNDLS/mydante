Proust::Application.routes.draw do

  get "home/index"
  
  # match '/auth/:provider/callback', :to => 'authentications#create'
  # match '/auth/failure', :to => 'authentications#failure'

  root :to => "home#index"
  
  resources :people,  :posts, :media, :authentications

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users do
    get :dashboard
  end

end