require 'sidekiq/web'

Rails.application.routes.draw do
  scope module: :web do
    #--- users ---#
    authenticated :user do
      root to: 'home#index', as: :authenticated_root
    end
    root to: redirect('/users/sign_in')

    devise_for :users, controllers: {
      sessions: 'web/users/sessions',
      registrations: 'web/users/registrations',
      passwords: 'web/users/passwords',
      confirmations: 'web/users/confirmations',
      unlocks: 'web/users/unlocks'
    }
    scope '/admin' do
      resources :users, except: %i[show edit update destroy]
    end
    resources :users, only: %i[show edit update destroy] do
      member do
        post :lock
        post :unlock
        post :restore
      end
    end
    #----#

    namespace :collection do
      resources :items do
        post 'restore', on: :member
        resources :fields do
          post 'restore', on: :member
        end
        resources :values
      end
    end

    namespace :blog do
      resources :posts do
        post 'restore', on: :member
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
