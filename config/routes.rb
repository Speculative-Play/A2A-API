Rails.application.routes.draw do
  namespace :api do

    namespace :v1 do

      # resources :sessions

      # resources :users, param: :_username
      # post '/auth/login', to: 'authentication#login'
      # get '/*a', to: 'application#not_found'
      resources :user_profiles, param: :email, shallow: true do

        collection do
          post 'update_piechart_percentages'
        end
        resources :parent_accounts, shallow: true do
          resources :starred_match_profiles
        end
        resources :user_question_answers
      end

      resources :match_profiles do
        collection do
          get 'reorder_match_profiles'
          get 'sort_match_profiles_by_attribute'
        end
        resources :match_question_answers
      end

      resources :matchmaking_categories, shallow: true do
        resources :category_percentages, shallow: true do
          resources :questions, shallow: true do
            resources :answers
          end
        end
      end

      # Defines the root path route ("/")
      # root "homepage#index"

      post '/auth/login', to: 'authentication#login'
      get '/*a', to: 'application#not_found'
      get 'signup', to: 'user_profiles#new', as: 'signup'
      get 'login', to: 'sessions#new', as: 'login'
      delete 'logout', to: 'sessions#destroy', as: 'logout'
      get 'about', to: 'pages#index'
      

    end
  end
end
