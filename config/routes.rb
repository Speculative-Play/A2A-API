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
        resources :favourited_match_profiles, shallow: true

        put '(/:id)/category_percentages', to: 'category_percentages#update'
      end

      resources :match_profiles, shallow: true do
        collection do
          get 'reorder_match_profiles'
          get 'sort_match_profiles_by_attribute'
        end
        resources :match_question_answers, shallow: true
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

      get 'my_question_answers', to: 'user_question_answers#index'

      get 'user_profile', to: 'user_profiles#show'
      put 'user_profile/edit', to: 'user_profiles#update'
      get 'user_profile/get_user_questions_answers', to: 'user_question_answers#index'
      delete 'user_profile/delete', to: 'user_profiles#destroy'

      get 'category_percentages', to: 'category_percentages#index'

      # get 'about', to: 'pages#index'
      delete 'favourited_match_profiles(/:user_profile_id)', to: 'favourited_match_profiles#destroy'
      post 'favourited_match_profiles', to: 'favourited_match_profiles#create'
      post 'starred_match_profiles(/:parent_account_id)', to: 'starred_match_profiles#create'
      get '/user_profiles(/:user_profile_id)/get_user_questions_answers', to: 'user_question_answers#get_user_questions_answers'
      post '/search-child', to: 'parent_accounts#search_child'
      get '/view-child', to: 'parent_accounts#view_child'
      get '/questions/matchmaking_category(/:matchmaking_category_id)', to: 'questions#questions_by_category'
      
      get '/login', to: 'sessions#logged_in'
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'

      get 'signup_parent_account', to: 'parent_accounts#new'
      post '/signup_parent_account', to: 'parent_accounts#create'
      get 'signup', to: 'user_profiles#new'
      post 'signup', to: 'user_profiles#create'
    end

  end


end
