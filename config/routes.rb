Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
  resources :events
  post '/rsvps/:id', to: 'rsvps#create'
  delete '/rsvps/:id', to: 'rsvps#destroy'
  resources :rsvps
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'events#index'
end
