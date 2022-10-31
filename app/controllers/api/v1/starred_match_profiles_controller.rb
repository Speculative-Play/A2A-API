class Api::V1::StarredMatchProfilesController < ApplicationController
  before_action :current_account

  # GET /starred_match_profiles
  def index
    if !current_user_profile.nil?
      @starred_match_profiles = StarredMatchProfile.where(parent_profile_id: ParentProfile.find_by(user_profile_id: @current_user_profile))
      render json: @starred_match_profiles
    elsif !current_parent_profile.nil?
      @starred_match_profiles = StarredMatchProfile.where(parent_profile_id: @current_parent_profile)
      render json: @starred_match_profiles
    else
      return head(:unauthorized)
    end
  end

  # GET /starred_match_profiles/1
  def show
    render json: @starred_match_profile
  end

  # POST /starred_match_profiles
  def create
    if !current_parent_profile.nil?
      @starred_match_profile = StarredMatchProfile.new(starred_match_profile_params)
      @starred_match_profile.parent_profile_id = @current_parent_profile.id
      
      # If favourited_match_profile is already starred, render it
      if StarredMatchProfile.where("parent_profile_id = ? AND match_profile_id = ?", @starred_match_profile.parent_profile_id, @starred_match_profile.match_profile_id).exists?
        @starred_match_profile = StarredMatchProfile.where("parent_profile_id = ? AND match_profile_id = ?", @starred_match_profile.parent_profile_id, @starred_match_profile.match_profile_id)
        render json: @starred_match_profile
      # else if starred_match_profile can be created, save it
      elsif @starred_match_profile.save
        render json: @starred_match_profile, status: :created
      else
        render json: @starred_match_profile.errors, status: :unprocessable_entity
      end
    else
      return head(:unauthorized)
    end
  end

  # DELETE /starred_match_profiles/1
  def destroy
    # if parent_profile is signed in
    if !current_parent_profile.nil?
      @starred_match_profile = StarredMatchProfile.find_by(id: params[:starred_match_profile_id])
      
      # if starred_match_profile with given id does not exist, return
      if @starred_match_profile.nil?
        return
      end
      
      # if starred_match_profile does not belong to current_parent_profile, return 401
      if @starred_match_profile.parent_profile != @current_parent_profile
        return head(:unauthorized)
      end

      # if all checks pass, destroy record and render index
      @starred_match_profile.destroy
      index
    else
      return head(:unauthorized)
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def starred_match_profile_params
    params.require(:starred_match_profile).permit(:parent_profile_id, :match_profile_id)
  end
end
