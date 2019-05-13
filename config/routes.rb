Rails.application.routes.draw do
  devise_for :users

  get '/' => 'homes#top', as: 'home'
  get '/about' => 'homes#about', as: 'about'

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :favotites
      get :history
      get :leave
      get :talk
    end
  end

  resources :articles, only: [:new, :show, :create, :destroy, :update] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    collection do
      get :skate
      get :hiphop
    end
  end

  resources :contacts, only: [:index, :show, :create, :new]
  resources :rooms, only: [:show, :create]
  resources :messages, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
