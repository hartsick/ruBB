Rails.application.routes.draw do
  devise_for :users
  
  resources :topics, except: %i[edit delete]
  resources :profile, only: %i[show edit update], param: :username
  get 'profile', to: 'profile#mine', as: :my_profile

  root 'topics#index'
end
