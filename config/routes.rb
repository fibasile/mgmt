Rails.application.routes.draw do

  resources :students
  get 'report_card', to: 'students#report_card'

  resources :courses
  resources :password_resets
  resources :users
  resources :sessions

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'password_resets/new'
  get 'invite/:invitation_code', to: 'users#invite', as: 'invite'
  # get 'signup', to: 'users#new', as: 'signup'

  namespace :office do
    resources :users
    resources :courses do
      resources :course_tutors
    end
    root to: 'users#index'
  end

  root to: 'students#report_card'
end
