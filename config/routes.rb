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
        resources :user_question_answers, shallow: true
        resources :category_percentages, shallow: true
        put '(/:id)/category_percentages', to: 'category_percentages#update'
        # get '(/:id)/user_question_answers(/:id)', to: 'user_question_answers#get_individual_user_profile_user_question_answer'
      end

      resources :match_profiles, shallow: true do
        collection do
          get 'reorder_match_profiles'
          get 'sort_match_profiles_by_attribute'
        end
        resources :match_question_answers, shallow: true
        # get '(/:id)/match_question_answers(/:id)', to: 'match_question_answers#get_individual_match_profile_match_question_answer'
      end

      resources :matchmaking_categories, shallow: true do
        resources :category_percentages, shallow: true do
          resources :questions, shallow: true do
            resources :answers, shallow: true
          end
        end
      end
      resources :questions
      resources :answers

      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#is_logged_in?'
      get 'signup', to: 'user_profiles#new', as: 'signup'
      get 'about', to: 'pages#index'
      get '/compare_qa(:id)', to: 'application#compare_qa', as: :compare_qa
    end

  end

end
