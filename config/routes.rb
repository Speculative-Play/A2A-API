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
      delete 'delete-account', to: "accounts#destroy"

      # Sessions
      get    '/login',   to: 'sessions#new'
      post   '/login',   to: 'sessions#create'
      delete '/logout',  to: 'sessions#destroy'

      # User Profiles
      get 'signup-user', to: 'user_profiles#new'
      post 'signup-user', to: 'user_profiles#create'
      get 'user_profile', to: 'user_profiles#show'
      put 'user_profile/edit', to: 'user_profiles#update'
      delete 'user_profile/delete', to: 'user_profiles#destroy'
      get 'user_profile/get_user_questions_answers', to: 'user_question_answers#index'
      get '/user_profiles(/:user_profile_id)/get_user_questions_answers', to: 'user_question_answers#get_user_questions_answers'
      post '/user_profile/avatar', to: "user_profiles#set_avatar"

      # Parent Accounts
      get 'signup-parent', to: 'parent_profiles#new'
      post 'signup-parent', to: 'parent_profiles#create'
      post '/search-child', to: 'parent_profiles#search_child'
      get '/view-child', to: 'parent_profiles#view_child'

      # Match Profiles
      post 'match', to: 'match_profiles#match'
      post 'search-matches', to: 'match_profiles#search_matches'

      # Favourited Match Profiles
      get 'favourited_match_profiles', to: 'favourited_match_profiles#index'
      post 'favourited_match_profiles', to: 'favourited_match_profiles#create'
      delete 'favourited_match_profiles/delete', to: 'favourited_match_profiles#destroy'

      # Starred Match Profiles
      get 'starred_match_profiles', to: 'starred_match_profiles#index'
      post 'starred_match_profiles', to: 'starred_match_profiles#create'
      delete 'starred_match_profiles/delete', to: 'starred_match_profiles#destroy'

      # Questions
      get '/questions/matchmaking_category(/:matchmaking_category_id)', to: 'questions#questions_by_category'

      # User Question Answers
      get 'my_question_answers', to: 'user_question_answers#index'
      put 'toggle_question(/:question_id)', to: 'user_question_answers#toggle_question'

      # Category Percentages
      get 'category_percentages', to: 'category_percentages#index'
      put 'category_percentages', to: 'category_percentages#update'

    end

  end

end