MyDante::Application.routes.draw do
  resources :guides

  root :to => 'home#index'

  # devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  #                                      
  # match 'signout' => 'sessions#destroy', :method => 'delete'
  
  resources :users, :only => :show do
    # get :dashboard, :greet
    resources :journals, :annotations
  end
  resources :people, :posts, :media, :discussions, :guides
  
  get 'media/*file_path.:file_format' => 'media#show'

end