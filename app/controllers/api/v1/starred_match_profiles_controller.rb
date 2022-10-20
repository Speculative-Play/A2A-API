class Api::V1::StarredMatchProfilesController < ApplicationController
  before_action :authenticate_parent_account

  # GET /starred_match_profiles
  def index
    # Returns all starred_match_profiles that share parent_account_id
    @starred_match_profiles = if params[:parent_account_id].present?
      StarredMatchProfile.where("parent_account_id = ?", params[:parent_account_id])
    end
    render json: @starred_match_profiles
  end

  # GET /starred_match_profiles/1
  def show
    render json: @starred_match_profile
  end

  # POST /starred_match_profiles/[parent_account_id]
  def create
    @starred_match_profile = StarredMatchProfile.new(starred_match_profile_params)
    if @starred_match_profile.save
      render json: @starred_match_profile, status: :created
    else
      render json: @starred_match_profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /starred_match_profiles/1
  def update
    if @starred_match_profile.update(starred_match_profile_params)
      render json: @starred_match_profile
    else
      render json: @starred_match_profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /starred_match_profiles/1
  def destroy
    @starred_match_profile.destroy
  end

  private
    def authenticate_parent_account
      if logged_in_parent_account?
        puts "inside parent_account > authenticate_parent_account > logged in!"
      else
        puts "inside parent_account > authenticate_parent_account > login unsuccessful!"
      end
    end

    # Only allow a list of trusted parameters through.
    def starred_match_profile_params
      # params.fetch(:starred_match_profile, {})
      params.require(:starred_match_profile).permit(:parent_account_id, :match_profile_id)
    end
end
