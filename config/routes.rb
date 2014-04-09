Compilandoideas::Application.routes.draw do
  
  root :to => 'posts#last', :as => :welcome

  resources :categories

  match 'comments/pending_comments' => 'comments#pending_comments'

  resources :comments

  match 'posts/program' => 'posts#program'

  resources :posts

  match 'profile(/:id)' => 'users#show#(/:id)', :as => :profile

  resources :users

  controller :sessions do
		get 'login' => :new
		post 'login' => :create
    #get 'autologin' => :create
		get 'logout' => :destroy
	end

  match ':controller(/:action)(/:id)'




end
