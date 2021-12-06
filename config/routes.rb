Rails.application.routes.draw do
  devise_for :users
  
  resources :topics, only: %i[index new create show]

  root 'topics#index'
end
