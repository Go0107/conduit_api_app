Rails.application.routes.draw do
  get 'users/index'
  
  scope :api do
    resources :users, only: [:index, :create]
    post "users/login", to: "users#login"
  end
end
