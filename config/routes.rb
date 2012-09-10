Compilandoideas::Application.routes.draw do
  
  root :to => 'posts#last'

  resources :categories

  resources :comments

  match 'post/publish_now' => 'posts#publish_now'

  resources :posts

  resources :users

  controller :sessions do
		get 'login' => :new
		post 'login' => :create
    #get 'autologin' => :create
		get 'logout' => :destroy
	end

  match ':controller(/:action)(/:id)'




end
