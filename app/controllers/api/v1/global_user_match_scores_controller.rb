class Api::V1::GlobalUserMatchScoresController < ApplicationController
    before_action :current_account
  
    # GET 
    def new
    end
  
    # GET /
    def show
      if !current_account.nil?
        # render global match score
      else
        return head(:unauthorized)
      end
    end
  
    # POST /create_global_score
    def create
      if !current_account.nil?
        # called whenever a new user_profile is created
        # for every match_profile
        current_user = current_account.user_profile
        MatchProfile.find_each do |match_profile|
          # create a global match score with current_user and every match_profile
          global_user_match_score = GlobalUserMatchScore.new(user_profile_id: current_user.id, match_profile_id: match_profile.id)
          if global_user_match_score.save
            next
          else
            render json: global_user_match_score.errors, status: :unprocessable_entity
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
        def global_user_match_score_params
          params.require(:global_user_match_score).permit(:user_profile_id, :match_profile_id, :score)
        end
  end