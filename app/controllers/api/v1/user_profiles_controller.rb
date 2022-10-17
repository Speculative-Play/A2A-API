class Api::V1::UserProfilesController < ApplicationController
  before_action :authenticate_user_profile

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

  def profiles_root_placeholder
    puts "inside user_profiles_controller > profiles_root_placeholder"
  end

  # GET /user_profiles/1
  def show
    puts "inside user_profiles_controller > show"
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
    puts "inside user_profiles_controller > update"
    @user_profile = current_user_profile
    puts "user profile id =",@user_profile.id
    if @user_profile.update(user_profile_params)
      render :show, status: :ok
    else
      render json: @user_profile.errors, status: :unprocessable_entity
    end
    puts "leaving user_profiles_controller > update"

  end

  # DELETE /user_profiles/1 or /user_profiles/1.json
  def destroy
    @user_profile = current_user_profile
    if @user_profile.destroy
      puts "redirect to logged out page"
    end
    # session[:user_profile_id] = nil if @user_profile == current_user_profile
  end

  private
    def authenticate_user_profile
      puts "inside UserProfiles > authenticate_user_profile"
      # logged_in_user_profile?
      # if !current_user_profile.nil?
      unless logged_in_user_profile?
        # flash[:danger] = "Please log in."
        # redirect_to login_url
        puts "2nd logged_in_user_profile as=", @current_user_profile.id

        puts "!!! you are not logged in! please login to continue!"
        render json: 'You are not logged in! Please log in to continue.', status: :unprocessable_entity
      else
        puts "inside UserProfiles > authenticate_user_profile > login successful!"
      end
      puts "leaving UserProfiles > authenticate_user_profile"

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
