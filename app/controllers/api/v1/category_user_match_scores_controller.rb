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