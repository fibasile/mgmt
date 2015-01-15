Rails.application.routes.draw do
  get 'password_resets/new'

  get 'report_card', to: 'students#report_card'
  # get 'all', to: 'students#all_report_cards'
  
  resources :courses
  resources :password_resets
  # get 'signup', to: 'users#new', as: 'signup'
  resources :users
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'invite/:invitation_code', to: 'users#invite', as: 'invite'

  # resources :users
  resources :sessions


  root to: 'students#report_card'
end
