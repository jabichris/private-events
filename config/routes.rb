Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#show'
  get 'users/sign_in'
  post 'users/logging'
  post 'events/attend_to_event'
  get 'users/sign_out'
  post 'events/invite_to_event'
  get 'users/notifications'
  post 'users/attend_event'
  post 'users/decline_invitation'
  resources :users, only:  [:show, :new, :create, :sign_in, :logging, :sign_out, :notifications, 
    :attend_event, :decline_invitation]
  resources :events, only: [:index, :show, :new, :create, :attend_to_event, :invite_to_event]
  
end
