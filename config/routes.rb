Rails.application.routes.draw do
  get 'users/index'
  
  scope :api do
    resources :users, only: [:index, :create]
  end
end
