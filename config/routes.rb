Rails.application.routes.draw do
  devise_for :users

  get '/' => 'homes#top', as: 'home'
  get '/about' => 'homes#about', as: 'about'

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :favorites
      get :histroy
      get :leave
    end
  end

  resources :articles, only: [:new, :show, :create, :destroy, :update, :edit] do
    resources :comments, only: [:create, :destroy] do
      resource :responses, only: [:create, :destroy]
    end
    resource :favorites, only: [:create, :destroy]
    collection do
      get :skate
      get :hiphop
      get :admin_article_index
      get :skate_practice
    end
  end

  resources :contacts, only: [:index, :show, :create, :new, :destroy] do
    member do
      get :user_contact_list
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
