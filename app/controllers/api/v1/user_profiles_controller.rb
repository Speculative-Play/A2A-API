class Api::V1::UserProfilesController < ApplicationController
  before_action :set_user_profile, only: %i[ show edit update destroy ]
  before_action :require_user_profile, only: [:edit, :update]
  before_action :require_same_user_profile, only: [:edit, :update, :destroy]

  # GET /user_profiles
  def index
    @user_profiles = UserProfile.all
    render json: @user_profiles
  end

  # GET /user_profiles/1
  def show
    render json: @user_profile
  end

  # GET /user_profiles/new
  def new
    @user_profile = UserProfile.new
  end

  # GET /user_profiles/1/edit
  def edit
  end

  # POST /user_profiles or /user_profiles.json
  def create
    @user_profile = UserProfile.new(user_profile_params)

    # respond_to do |format|
      if @user_profile.save
        session[:user_profile_id] = user_profile.id
        render json: {
          status: :created,
          user: @user
        }
        # format.html { redirect_to user_profile_url(@user_profile), notice: "UserProfile was successfully created." }
        # format.json { render :show, status: :created, location: @user_profile }
      else
        @user.save
        render json: {
          status: 500,
          error: @user.errors.full_messages
        }
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /user_profiles/1 or /user_profliles/1.json
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to user_profile_url(@user_profile), notice: "UserProfile was successfully updated." }
        format.json { render :show, status: :ok, location: @user_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_profiles/1 or /user_profiles/1.json
  def destroy
    @user_profile.destroy
    session[:user_profile_id] = nil if @user_profile == current_user_profile

    respond_to do |format|
      format.html { redirect_to user_profiles_url, notice: "UserProfile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def update_piechart_percentages
  #   Rails.logger.info 'hello from update_piechart_percentages'

  #   respond_to do |format|
  #     if @profile.update(pie_params[:pie_percentages])
  #       format.json { redirect_to @profile, notice: 'Profile was successfully updated.' }
  #     else
  #       format.json { render json: @profile.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_profile_params
      params.require(:user_profile).permit(:email, :password, :password_confirmation)
    end

    def require_same_user_profile
      if current_user_profile != @user_profile && !current_user_profile.admin?
        flash[:alert] = "You can only edit or delete your own account"
        redirect_to @user_profile
      end
    end

    def pie_params
      params.permit!
      # params.permit(pie_percentages: [:cultureScore, :facialScore, :lifestyleScore, :kundaliScore, :locationScore])
    end
end
