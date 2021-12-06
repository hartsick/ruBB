Rails.application.routes.draw do
  get 'page/home'

  root 'page#home'
end
