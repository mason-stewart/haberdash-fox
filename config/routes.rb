HaberdasherFox::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get '/' => 'collection#index'
  get '/collection/:slug' => 'collection#show'
end
