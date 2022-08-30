class Api::V1::MatchProfilesController < ApplicationController
  # before_action :set_profile
  before_action :set_match_profile, only: %i[ show edit update destroy ]
  before_action :get_match_profiles

  # GET /match_profiles
  def index
    @match_profiles = MatchProfile.all
    render json: @match_profiles
  end

  # GET /match_profiles/1
  def show
    render json: @match_profile
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

    if @match_profile.save
      render json: {
        status: :created,
        match_profile: @match_profile
      }
    else
      render json: @match_profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /match_profiles/1 or /match_profiles/1.json
  def update
    # respond_to do |format|
      if @match_profile.update(match_profile_params)
        # format.html { redirect_to match_profile_url(@match_profile), notice: "Match profile was successfully updated." }
        format.json { render :show, status: :ok, location: @match_profile }
      else
        # format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match_profile.errors, status: :unprocessable_entity }
      end
    # end
  end

  # DELETE /match_profiles/1 or /match_profiles/1.json
  def destroy
    @match_profile.destroy

    respond_to do |format|
      format.html { redirect_to match_profiles_url, notice: "Match profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /reorder_match_profiles.json
  def reorder_match_profiles
    Rails.logger.info 'hello from match_profiles_controller/reorder_match_profiles'
    @match_profiles = MatchProfile.all
    respond_to do |format|
      if @match_profiles.index()
            format.json { render :partial => 'reorder_match_profiles.html.erb' }
            # TODO this needs to be linked to correct react view
      end
    end
  end

  def sort_match_profiles_by_attribute
    Rails.logger.info 'hello from sort_match_profiles_by_attribute'

    # @match_profiles = MatchProfile.order("#{params[:sort]}").reverse
    # @match_profiles = MatchProfile.find(:all, :order => )

    Rails.logger.info 'inside sort_match_by_attributes match_profiles_controller'
    @match_profiles = MatchProfile.all
    respond_to do |format|
      # @match_profiles.sort_by {|prof| prof.culture_score}
      @match_profiles.sort_match_profiles_by_attribute(match_profile_params[:attribute])
    format.json { render :partial => 'reorder_match_profiles.html.erb' }
    end
  end

  

  private
    # def set_profile
    #   @profile = current_user.profile
    # end

    # Use callbacks to share common setup or constraints between actions.
    def set_match_profile
      @match_profile = MatchProfile.find(params[:id])
    end

    def get_match_profiles
      @match_profiles = MatchProfile.all
    end

    # Only allow a list of trusted parameters through.
    def match_profile_params
      # params.fetch(:match_profile, {})
      params.require(:match_profile).permit(:first_name, :last_name)

    end
end
