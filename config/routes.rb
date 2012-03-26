Proust::Application.routes.draw do

  root :to => "home#index"
  
  resources :people,  :posts, :media, :authentications

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users do
    get :dashboard, :greet
    resources :journals, :discussions
  end

end