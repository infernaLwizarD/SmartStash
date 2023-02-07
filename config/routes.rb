Rails.application.routes.draw do
  devise_for :users

  require 'sidekiq/web'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'
end
