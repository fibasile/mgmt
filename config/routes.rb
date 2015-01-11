Rails.application.routes.draw do
  resources :courses
  devise_for :users
  get 'report_card', to: 'students#report_card'
  root to: 'students#report_card'
end
