Rails.application.routes.draw do



  resources :students
  get 'report_card', to: 'students#report_card'

  resources :courses
  resources :password_resets
  resources :users, path: 'people'
  resources :sessions

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'password_resets/new'
  get 'invite/:invitation_code', to: 'users#invite', as: 'invite'
  # get 'signup', to: 'users#new', as: 'signup'

  namespace :office do
    resources :labs, path: 'labs' do
      resources :lab_programs, path: 'programs'
    end
    resources :users, path: 'people' do
      member do
        get 'report'
      end
    end
    resources :programs do
      member do
        get 'grades'
      end
      resources :program_students, path: 'students'
      resources :program_courses, path: 'courses'
    end
    resources :courses do
      put 'grades' => 'grades#create', on: :member
      resources :grades do
        collection do
          post 'submit'
        end
      end
      resources :course_tutors, path: 'tutors'
      resources :course_students, path: 'students'
    end
    root to: 'courses#index'
  end

  root to: 'students#report_card'
end
