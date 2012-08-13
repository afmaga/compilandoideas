Compilandoideas::Application.routes.draw do
  
  resources :categories

  resources :comments

  resources :posts

  resources :users

  controller :sessions do
		get 'login' => :new
		post 'login' => :create
    #get 'autologin' => :create
		get 'logout' => :destroy
	end

  match ':controller(/:action)(/:id)', :constraints => { :id => /\d/}

  root :to => 'application#index'


end
