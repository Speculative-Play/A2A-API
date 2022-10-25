Rails.application.routes.draw do
  namespace :api do
    
    namespace :v1 do

      resources :accounts
      resources :sessions
      resources :user_profiles
      resources :parent_profiles
      resources :match_profiles
      resources :questions
      resources :answers
      resources :user_question_answers
      resources :match_question_answers
      resources :matchmaking_categories
      resources :category_percentages
      resources :favourited_match_profiles
      resources :starred_match_profiles

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
      get 'signup-user', to: 'user_profiles#new'
      post 'signup-user', to: 'user_profiles#create'
      get 'user_profile', to: 'user_profiles#show'
      put 'user_profile/edit', to: 'user_profiles#update'
      get 'user_profile/get_user_questions_answers', to: 'user_question_answers#index'
      delete 'user_profile/delete', to: 'user_profiles#destroy'
      get '/user_profiles(/:user_profile_id)/get_user_questions_answers', to: 'user_question_answers#get_user_questions_answers'
      post '/match', to: 'user_profiles#match'


      # Parent Accounts
      get 'signup-parent', to: 'parent_profiles#new'
      post 'signup-parent', to: 'parent_profiles#create'
      post '/search-child', to: 'parent_profiles#search_child'
      get '/view-child', to: 'parent_profiles#view_child'

      # Favourited Match Profiles
      get 'favourites', to: 'favourited_match_profiles#index'
      post 'favourite', to: 'favourited_match_profiles#create'
      delete 'remove-favourite', to: 'favourited_match_profiles#destroy'

      # Starred Match Profiles
      get 'starred_match_profiles', to: 'starred_match_profiles#index'
      post 'starred_match_profiles', to: 'starred_match_profiles#create'
      # get 'reorder_match_profiles'
      # get 'sort_match_profiles_by_attribute'

      # Questions
      get '/questions/matchmaking_category(/:matchmaking_category_id)', to: 'questions#questions_by_category'

      # Answers
      get 'my_question_answers', to: 'user_question_answers#index'

      # Category Percentages
      get 'category_percentages', to: 'category_percentages#index'
      put 'category_percentages', to: 'category_percentages#update'

    end

  end

end