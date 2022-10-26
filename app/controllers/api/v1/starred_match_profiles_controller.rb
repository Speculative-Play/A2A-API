class Api::V1::StarredMatchProfilesController < ApplicationController
  before_action :current_account

  # GET /starred_match_profiles
  def index
    puts "insie starred_match_profile controller > index"
    puts "now will check for a current user"
    if !current_user_profile.nil?
      @starred_match_profiles = StarredMatchProfile.where(parent_profile_id: ParentProfile.find_by(user_profile_id: @current_user_profile))
      render json: @starred_match_profiles
    elsif !current_parent_profile.nil?
      @starred_match_profiles = StarredMatchProfile.where(parent_profile_id: @current_parent_profile)
      render json: @starred_match_profiles
    else
      render json: "must be logged in to do that."
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
        @starred_match_profile = StarredMatchProfile.where("parent_profile_id = ? AND match_profile_id = ?", @favourited_match_profile.parent_profile_id, @favourited_match_profile.match_profile_id)
        render json: @favourited_match_profile
      # else if starred_match_profile can be created, save it
      elsif @starred_match_profile.save
        render json: @starred_match_profile, status: :created
      else
        render json: @starred_match_profile.errors, status: :unprocessable_entity
      end
    else
      render json: "must be logged in as parent!"
    end
  end

  # # PATCH/PUT /starred_match_profiles/1
  # def update
  #   if @starred_match_profile.update(starred_match_profile_params)
  #     render json: @starred_match_profile
  #   else
  #     render json: @starred_match_profile.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /starred_match_profiles/1
  def destroy
    @starred_match_profile.destroy
  end

  private
  # Only allow a list of trusted parameters through.
  def starred_match_profile_params
    # params.fetch(:starred_match_profile, {})
    params.require(:starred_match_profile).permit(:parent_profile_id, :match_profile_id)
  end
end
