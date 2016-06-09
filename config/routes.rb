Rails.application.routes.draw do
  devise_for :users
  resources :jokes

  root 'home#index'
end
