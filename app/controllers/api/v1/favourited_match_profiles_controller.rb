class Api::V1::FavouritedMatchProfilesController < ApplicationController
  # before_action :set_favourited_match_profile, only: %i[ show update destroy ]

  # GET /favourited_match_profiles
  def index
    # Returns all starred_match_profiles that share parent_account_id
    @favourited_match_profiles = if params[:user_profile_id].present?
      FavouritedMatchProfile.where("user_profile_id = ?", params[:user_profile_id])
    end
    render json: @starred_match_profiles
  end

  # GET /favourited_match_profiles/1
  def show
    render json: @favourited_match_profile
  end

  # POST /favourited_match_profiles
  def create
    @favourited_match_profile = FavouritedMatchProfile.new(favourited_match_profile_params)
    if @favourited_match_profile.save
      render json: @favourited_match_profile, status: :created, location: @favourited_match_profile
    else
      render json: @favourited_match_profile.errors, status: :unprocessable_entity
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
    puts "begin destroy"
    @json = JSON.parse(request.body.read)
    @match_profile_id = @json["favourited_match_profile"]["match_profile_id"]
    @favourited_match_profile = FavouritedMatchProfile.where("user_profile_id = ? AND match_profile_id = ?", params[:user_profile_id], @match_profile_id)
    puts "favourited_match_profile found = ", @favourited_match_profile

    @id = @favourited_match_profile.ids
    puts "id found = ", @id
    @favourited_match_profile = FavouritedMatchProfile.where("id = ?", @id)
    # if params[:user_profile_id].present?
    puts "favourited_match_profile found = ", @favourited_match_profile
    # end
    @favourited_match_profile.destroy
    puts "end destroy"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favourited_match_profile
      @favourited_match_profile = FavouritedMatchProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favourited_match_profile_params
      # params.fetch(:favourited_match_profile, {})
      params.require(:favourited_match_profile).permit(:user_profile_id, :match_profile_id)
    end
end
