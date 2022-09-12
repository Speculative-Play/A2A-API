class Api::V1::StarredMatchProfilesController < ApplicationController
  before_action :set_starred_match_profile, only: %i[ show update destroy ]

  # GET /starred_match_profiles
  def index
    # Returns all starred_match_profiles that share parent_account_id
    @starred_match_profiles = StarredMatchProfile.where("parent_account_id = ?", params[:parent_account_id])
    render json: @starred_match_profiles
  end

  # GET /starred_match_profiles/1
  def show
    render json: @starred_match_profile
  end

  # POST /starred_match_profiles
  def create
    # TODO: need to make this find a match_profile and link it to this
    @starred_match_profile = StarredMatchProfile.new(starred_match_profile_params)

    if @starred_match_profile.save
      render json: @starred_match_profile, status: :created, location: @starred_match_profile
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
    # Use callbacks to share common setup or constraints between actions.
    def set_starred_match_profile
      @starred_match_profile = StarredMatchProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def starred_match_profile_params
      params.fetch(:starred_match_profile, {})
    end
end
