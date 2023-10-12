class Api::V1::CategoryUserMatchScoresController < ApplicationController
    before_action :current_account
  
    # GET 
    def new
    end
  
    # GET /
    def show
      if !current_account.nil?
        # render category match score
      else
        return head(:unauthorized)
      end
    end
  
    # POST /create_category_score
    def create
      if !current_account.nil?
        # called whenever a new user_profile is created
        # for every match_profile
        current_user = current_account.user_profile
        MatchProfile.find_each do |match_profile|
          MatchmakingCategory.find_each do |matchmaking_category|
            category_percentage = CategoryPercentage.where(user_profile_id: current_user.id).where(matchmaking_category_id: matchmaking_category.id)
            # create a category match score with current_user and every match_profile
            category_user_match_score = CategoryUserMatchScore.new(user_profile_id: current_user.id, match_profile_id: match_profile.id, matchmaking_category_id: matchmaking_category.id, category_percentage: category_percentage.category_percentage)
            if category_user_match_score.save
              next
            else
              render json: category_user_match_score.errors, status: :unprocessable_entity
            end
        end
      else
        return head(:unauthorized)
      end
    end
  
    # PATCH/PUT /category_user_match_score/1
    def update

    end
  
      private
        # Only allow a list of trusted parameters through.
        def category_user_match_score_params
          params.require(:category_user_match_score).permit(:user_profile_id, :match_profile_id, :matchmaking_category_id, :category_percentage_id, :score)
        end
  end