Rails.application.routes.draw do
  namespace :api do
    
    namespace :v1 do

      resources :sessions
      resources :user_profiles, only: [:create]
      resources :user_profiles, shallow: true do
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
      # root 'api/v1'
      post '/login', to: 'sessions#create'
      # delete '/logout', to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#is_logged_in?'
      get 'signup', to: 'user_profiles#new', as: 'signup'
      # get 'login', to: 'sessions#new', as: 'login'
      delete 'logout', to: 'sessions#destroy', as: 'logout'
      get 'about', to: 'pages#index'
    end

  end

end
