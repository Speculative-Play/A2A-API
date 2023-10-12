class Api::V1::FavouritedMatchProfilesController < ApplicationController
  before_action :current_account

  # GET /favourites
  def index
    # Returns all favourited_match_profiles that share current_user_profile's id
    if !current_user_profile.nil?
      @favourited_match_profiles = FavouritedMatchProfile.where(user_profile_id: @current_user_profile.id)
      render json: @favourited_match_profiles
    else
      return head(:unauthorized)
    end
  end

  # GET /favourite/1
  def show
    render json: @favourited_match_profile
  end

  # POST /favourite
  def create
    if !current_user_profile.nil?
      @favourited_match_profile = FavouritedMatchProfile.new(favourited_match_profile_params)
      @favourited_match_profile.user_profile_id = @current_user_profile.id

      # If favourited_match_profile is already favourited, only render index
      if FavouritedMatchProfile.where("user_profile_id = ? AND match_profile_id = ?", @favourited_match_profile.user_profile_id, @favourited_match_profile.match_profile_id).exists?
        index
      # else if favourited_match_profile can be created, save it and render index
      elsif @favourited_match_profile.save
        index
      else
        render json: @favourited_match_profile.errors, status: :unprocessable_entity
      end
    else
      return head(:unauthorized)
    end
  end

  # DELETE /favourited_match_profiles/delete
  def destroy
    # if user_profile is signed in
    if !current_user_profile.nil?
      @favourited_match_profile = FavouritedMatchProfile.find_by(id: params[:favourited_match_profile_id])
      
      # if favourited_match_profile with given id does not exist, return
      if @favourited_match_profile.nil?
        return
      end
      
      # if favourited_match_profile does not belong to current_user_profile, return 401
      if @favourited_match_profile.user_profile != @current_user_profile
        return head(:unauthorized)
      end

      # if all checks pass, destroy record and render index
      @favourited_match_profile.destroy
      index
    else
      return head(:unauthorized)
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def favourited_match_profile_params
      params.require(:favourited_match_profile).permit(:user_profile_id, :match_profile_id)
    end
end
