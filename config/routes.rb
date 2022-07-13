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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
