Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :parent_accounts
        resources :profiles do
          collection do
            post 'update_piechart_percentages'
          end
          resources :user_answers
        end
      end
      resources :match_profiles do
        collection do
          get 'reorder_match_profiles'
          get 'sort_match_profiles_by_attribute'
        end
        resources :match_answers
      end
      resources :sessions
      resources :questions
      resources :answers
    end
  end
  # Defines the root path route ("/")
  # root "homepage#index"

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'about', to: 'pages#index'
end
