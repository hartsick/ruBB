Rails.application.routes.draw do
  devise_for :users
  
  resources :topics, except: %i[edit delete], constraints: { id: /\d+/ }
  get 'topics/today', to: 'topics#today', as: :today_topics
  get 'topics/mentions', to: 'topics#mentions', as: :my_mentions

  resources :profile, only: %i[show edit update], param: :username
  get 'profile', to: 'profile#mine', as: :my_profile

  root 'topics#today'
end
