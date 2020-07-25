Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post 'users/logging'
  resources :users, only:  [:show, :new, :create]
  resources :events, only: [:new, :create]
  root 'users#new'
end
