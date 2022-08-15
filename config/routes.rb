Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :user_profiles do
        resources :parent_accounts
        resources :profiles do
          collection do
            post 'update_piechart_percentages'
          end
                end
      end
      resources :match_profiles do
        collection do
          get 'reorder_match_profiles'
          get 'sort_match_profiles_by_attribute'
        end
            end
      resources :sessions
      resources :questions
      resources :answers
      resources :matchmaking_categories
      resources :category_percentages
      resources :starred_match_profiles
      resources :match_question_answers
      resources :user_question_answers
    end
  end
  # Defines the root path route ("/")
  # root "homepage#index"

  get 'signup', to: 'user_profiles#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'about', to: 'pages#index'
end
