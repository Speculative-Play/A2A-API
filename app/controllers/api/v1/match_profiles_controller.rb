class Api::V1::MatchProfilesController < ApplicationController
  before_action :set_match_profile, only: %i[ show edit update destroy ]

  # GET /match_profiles
  def index
    @match_profiles = MatchProfile.all
    # render json: @match_profiles
  end

  # GET /match_profiles/1
  def show
    # render json: @match_profile
  end

  # GET /match_profiles/new
  def new
    @match_profile = MatchProfile.new
  end

  # GET /match_profiles/1/edit
  def edit
  end

  # POST /match_profiles or /match_profiles.json
  def create
    @match_profile = MatchProfile.new(match_profile_params)

    respond_to do |format|
      if @match_profile.save
        format.html { redirect_to match_profile_url(@match_profile), notice: "Match profile was successfully created." }
        format.json { render :show, status: :created, location: @match_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /match_profiles/1 or /match_profiles/1.json
  def update
    respond_to do |format|
      if @match_profile.update(match_profile_params)
        format.html { redirect_to match_profile_url(@match_profile), notice: "Match profile was successfully updated." }
        format.json { render :show, status: :ok, location: @match_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /match_profiles/1 or /match_profiles/1.json
  def destroy
    @match_profile.destroy

    respond_to do |format|
      format.html { redirect_to match_profiles_url, notice: "Match profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_profile
      @match_profile = MatchProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_profile_params
      params.fetch(:match_profile, {})
    end
end
