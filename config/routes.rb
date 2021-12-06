Rails.application.routes.draw do
  devise_for :users
  
  get 'page/home'
  root 'page#home'
end
