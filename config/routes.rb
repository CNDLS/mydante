MyDante::Application.routes.draw do
  root :to => 'home#index'

  # devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # match 'signout' => 'sessions#destroy', :method => 'delete'
  
  resources :users, :only => :show do
    # get :dashboard
    resources :journals, :annotations
  end
  resources :people, :posts, :discussions, :guides, :sources
  
  resources :images do
    get :inline
  end
  
  get 'media/*file_path' => 'media#show', :as => :media

end