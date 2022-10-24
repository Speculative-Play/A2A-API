Rails.application.routes.draw do
  namespace :api do
    
    namespace :v1 do

      resources :accounts
      resources :sessions
      resources :user_profiles, only: [:create]
      resources :user_profiles, shallow: true do
        resources :parent_profiles, shallow: true do
          resources :starred_match_profiles
        end
        resources :user_question_answers, shallow: true
        resources :category_percentages, shallow: true
        resources :favourited_match_profiles, shallow: true
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

      # Custom Routes

      # Pages
      # get 'about', to: 'pages#index'

      # Accounts
      get  '/signup',  to: 'accounts#new'
      post '/signup',  to: 'accounts#create'

      # Sessions
      get    '/login',   to: 'sessions#new'
      post   '/login',   to: 'sessions#create'
      delete '/logout',  to: 'sessions#destroy'

      # User Profiles
      get 'user_profile', to: 'user_profiles#show'
      put 'user_profile/edit', to: 'user_profiles#update'
      get 'user_profile/get_user_questions_answers', to: 'user_question_answers#index'
      delete 'user_profile/delete', to: 'user_profiles#destroy'
      get '/user_profiles(/:user_profile_id)/get_user_questions_answers', to: 'user_question_answers#get_user_questions_answers'
      post '/match', to: 'user_profiles#match'


      # Parent Accounts
      get 'signup_parent_profile', to: 'parent_profiles#new'
      post '/signup_parent_profile', to: 'parent_profiles#create'
      post '/search-child', to: 'parent_profiles#search_child'
      get '/view-child', to: 'parent_profiles#view_child'

      # Favourited Match Profiles
      get 'favourites', to: 'favourited_match_profiles#index'
      post 'favourite', to: 'favourited_match_profiles#create'
      delete 'favourite', to: 'favourited_match_profiles#destroy'

      # Starred Match Profiles
      post 'starred_match_profiles', to: 'starred_match_profiles#create'

      # Questions
      get '/questions/matchmaking_category(/:matchmaking_category_id)', to: 'questions#questions_by_category'

      # Category Percentages
      get 'category_percentages', to: 'category_percentages#index'
      put 'category_percentages', to: 'category_percentages#update'

    end

  end

end
