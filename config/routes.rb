Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :profiles
      resources :match_profiles
      resources :sessions
      resources :questions
      resources :answers
      resources :user_answers
      resources :match_answers
    end
  end
  # Defines the root path route ("/")
  # root "homepage#index"
end
