Rails.application.routes.draw do
  resources :courses

  # get 'signup', to: 'users#new', as: 'signup'
  resources :users
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'invite/:invitation_code', to: 'users#invite', as: 'invite'

  # resources :users
  resources :sessions

  get 'report_card', to: 'students#report_card'
  root to: 'students#report_card'
end
