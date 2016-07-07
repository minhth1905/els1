Rails.application.routes.draw do
 root "static_pages#home"
 get "home" => "static_pages#home"
 get "help" => "static_pages#help"
 get "about" => "static_pages#about"
 get "contact" => "static_pages#contact"
 get "signup" => "users#new"
 get "login" => "sessions#new"
 post "login" => "sessions#create"
 delete "logout" => "sessions#destroy"

 namespace :admin do
   resources :users
   resources :categories
 end

 resources :categories, only: [:index, :show]
 resources :users, except: [:destroy]
 resources :relationships, only: [:create, :destroy, :index]

end
