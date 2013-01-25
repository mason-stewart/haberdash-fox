HaberdasherFox::Application.routes.draw do
  get "items/index"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'

  get '/' => 'collection#index'
  get '/collection/:slug' => 'collection#show'
  
  get '/items/:slug' => 'items#show'
end
