class Api::V1::SessionsController < ApplicationController
include ActionController::Cookies
  # GET /sessions
  def index
    @sessions = Session.all
    render json: @sessions
  end

  # GET /sessions/1
  def show
    render json: @session
  end

  def new
    puts "inside sessions#new"
  end

  # Creates session object that allows user_profile to be logged in persistently
  def create
    @user_profile = UserProfile.find_by(email: params[:session][:email])
    if @user_profile && @user_profile.authenticate(params[:session][:password_digest])
      # if user_profile.admin == 1
      #   redirect_to user_profiles_url, notice: "Logged in as ADMIN!"
      # else
      log_in @user_profile
      params[:session][:remember_me] == '1' ? remember(@user_profile) : forget(@user_profile)
      # session[:user_profile_id] = @user_profile.id
      render json: @user_profile
      # puts "User successfully logged in"
      # puts @user_profile.id
    else
      # render json: { 
      #   status: 401, 
      #   error: "Could not authenticate your account"
      # }
      puts "user could not be logged in"
      render :new
    end
    puts "leaving sessions#create"
  end

  # def logged_in
  #   @current_user_profile = UserProfile.find(session[:user_profile_id]) if session[:user_profile_id]
  #   if @current_user_profile
  #     render json: {
  #       logged_in: true,
  #       user: UserProfileSerializer.new(@current_user_profile)
  #     }
  #   else
  #     render json: {
  #       logged_in: false
  #     }
  #   end
  # end

  # PATCH/PUT /sessions/1
  # def update
  #   if @session.update(session_params)
  #     render json: @session
  #   else
  #     render json: @session.errors, status: :unprocessable_entity
  #   end
  # end

  def destroy
    # session.delete :user_id
    # render json: {
    #   status: 200,
    #   logged_out: true
    # }
    log_out
    redirect_to root_url
  end

  private

    # Only allow a list of trusted parameters through.
    def session_params
      puts "inside session_params method"
      # params.permit!
      params.require(:user_profile).permit(:email, :password_digest)
      # params.fetch(:session, {})
      puts "leaving session_params"
    end
end
