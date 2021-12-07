Rails.application.routes.draw do
  devise_for :users
  
  resources :topics, except: %i[edit delete]

  root 'topics#index'
end
