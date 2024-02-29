Rails.application.routes.draw do
  get 'articles/index'
  get 'users/index'
  
  scope :api do
    resources :users, only: [:index, :create]
    post "users/login", to: "users#login"
    resources :articles, only: [:index, :create, :update, :destroy, :show]
  end
end
