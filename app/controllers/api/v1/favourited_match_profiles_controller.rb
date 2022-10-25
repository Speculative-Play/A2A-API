class Api::V1::FavouritedMatchProfilesController < ApplicationController
  before_action :current_account

  # GET /favourites
  def index
    # Returns all favourited_match_profiles that share current_user_profile's id
    if !current_user_profile.nil?
      @favourited_match_profiles = FavouritedMatchProfile.where(user_profile_id: @current_user_profile.id)
      render json: @favourited_match_profiles
    else
      render json: "must be logged in as user"
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

      # If favourited_match_profile is already starred, only render index
      if FavouritedMatchProfile.where("user_profile_id = ? AND match_profile_id = ?", @favourited_match_profile.user_profile_id, @favourited_match_profile.match_profile_id).exists?
        index
      # else if starred_match_profile can be created, save it and render index
      elsif @favourited_match_profile.save
        index
      else
        render json: @favourited_match_profile.errors, status: :unprocessable_entity
      end
    else
      render json: "must be logged in"
    end
  end

  # PATCH/PUT /favourited_match_profiles/1
  def update
    if @favourited_match_profile.update(favourited_match_profile_params)
      render json: @favourited_match_profile
    else
      render json: @favourited_match_profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favourited_match_profiles
  def destroy
    if !current_user_profile.nil?
      @favourited_match_profile = FavouritedMatchProfile.find_by("user_profile_id = ? AND match_profile_id = ?", @current_user_profile.id, favourited_match_profile_params[:match_profile_id])
      @favourited_match_profile.destroy
      index
    else
      render json: "must be logged in as user to do that."
    end
  end

  private
    def authenticate_user_profile
      if logged_in_user_profile?
        render json: 'You are not logged in! Please log in to continue.', status: :unprocessable_entity
      end
    end

    # Only allow a list of trusted parameters through.
    def favourited_match_profile_params
      # params.fetch(:favourited_match_profile, {})
      params.require(:favourited_match_profile).permit(:user_profile_id, :match_profile_id)
    end
end
