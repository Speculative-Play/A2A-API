Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :user_profiles, shallow: true do
        collection do
          post 'update_piechart_percentages'
        end
        resources :parent_accounts, shallow: true do
          resources :starred_match_profiles
        end
      end
      resources :match_profiles do
        collection do
          get 'reorder_match_profiles'
          get 'sort_match_profiles_by_attribute'
        end
      end
      resources :sessions
      resources :matchmaking_categories, shallow: true do
        resources :category_percentages, shallow: true do
          resources :questions, shallow: true do
            resources :answers, shallow: true do
              resources :match_question_answers
              resources :user_question_answers
            end
          end
        end
      end
    end
  end
  # Defines the root path route ("/")
  # root "homepage#index"

  get 'signup', to: 'user_profiles#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'about', to: 'pages#index'
end
