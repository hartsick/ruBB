Rails.application.routes.draw do
  if Rails.configuration.x.invitations.enabled
    devise_for :users, controllers: { invitations: 'users/invitations' }
  else
    devise_for :users, skip: :invitations
  end
  get 'directory', to: 'users#index', as: :user_directory
  
  resources :topics, except: %i[edit delete], constraints: { id: /\d+/ } do
    post 'star', to: 'topics#star', as: :star
    post 'unstar', to: 'topics#unstar', as: :unstar
    post 'pin', to: 'topics#pin', as: :pin
    post 'unpin', to: 'topics#unpin', as: :unpin
  end
  get 'topics/mentions', to: 'topics#mentions', as: :my_mentions
  get 'topics/starred', to: 'topics#starred', as: :my_starred
  post 'topics/mark_as_read', to: 'topics#mark_as_read', as: :mark_as_read

  resources :profile, only: %i[show edit update], param: :username
  get 'profile', to: 'profile#mine', as: :my_profile

  root 'topics#index'
end
