class Api::V1::UserProfilesController < ApplicationController
  # before_action :set_user_profile, only: %i[ index show edit update destroy ]
  # before_action :require_user_profile, only: [:edit, :update, :destroy]
  # before_action :require_same_user_profile, only: [:edit, :update, :destroy]
  # include ActionController::Helpers
  before_action :authenticate_user_profile
  # around_action :current_user_profile
  # helper_method :current_user_profile


  # GET /user_profiles
  def index
    # puts "inside UserProfiles > index"
    # if authenticate_user_profile
      # puts "inside UserProfiles > if authenticate_user_profile == true"
      # render 'client_dashboard'
    # else
      # puts "inside UserProfiles > index > rendering index of all user_profiles"
      @user_profiles = UserProfile.all
      render json: @user_profiles
    # end
  end

  # GET /user_profiles/1
  def show
    @user_profile = current_user_profile
    render json: @user_profile
  end

  # POST /search-child
  def search_child
    email = params[:email]
    @user_profile = UserProfile.where("email = ?", email)

    # Might want some error / success message here
    # if @user_profile.exists?
    #   puts "found user"
    # else 
    #   puts "user not found"
    # end
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
    if @user_profile.save
      render json: {
        status: :created,
        user_profile: @user_profile
      }
    else
      render json: @user_profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_profiles/1 or /user_profliles/1.json
  def update
    @user_profile = current_user_profile
    if @user_profile.update(user_profile_params)
      render :show, status: :ok
    else
      render json: @user_profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_profiles/1 or /user_profiles/1.json
  def destroy
    @user_profile = current_user_profile
    if @user_profile.destroy
      puts "redirect to logged out page"
    end
    # session[:user_profile_id] = nil if @user_profile == current_user_profile
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
    def authenticate_user_profile
      puts "inside UserProfiles > authenticate_user_profile"
      unless logged_in?
        # flash[:danger] = "Please log in."
        # redirect_to login_url
        puts "inside UserProfiles > authenticate_user_profile > unless logged_in? ==  true"
        # redirect_to log_in
      else
        puts "inside UserProfiles > authenticate_user_profile > login successful!"
      end
    end

    def correct_user_profile
      @user_profile = UserProfile.find(params[:id])
      # redirect_to(root_url) unless current_user_profile?(@user_profile)
    end

    def require_same_user_profile
      if current_user_profile != @user_profile && !current_user_profile.admin?
        # flash[:alert] = "You can only edit or delete your own account"
        redirect_to @user_profile
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_profile_params
      params.require(:user_profile).permit(:email, :password, :first_name, :last_name, :admin, :image)
    end

    def pie_params
      params.permit!
      # params.permit(pie_percentages: [:cultureScore, :facialScore, :lifestyleScore, :kundaliScore, :locationScore])
    end
end
