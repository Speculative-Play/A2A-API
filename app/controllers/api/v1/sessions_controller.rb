class Api::V1::SessionsController < ApplicationController
  # before_action :set_session, only: %i[ show update destroy ]

  # GET /sessions
  def index
    @sessions = Session.all
    render json: @sessions
  end

  # GET /sessions/1
  def show
    render json: @session
  end

  # Creates session object that allows user_profile to be logged in persistently
  def create
    puts "inside session create!!!!!"
    # user_profile = UserProfile.find_by(email: params[:session][:email].downcase)
    @user_profile = UserProfile.find_by(email: session_params[:email])
    puts "user profile = ", @user_profile.id
    # if user_profile && user_profile.authenicate(params[:session][:password])
    if @user_profile && @user_profile.authenticate(session_params[:password])
      # if user_profile.admin == 1
      #   redirect_to user_profiles_url, notice: "Logged in as ADMIN!"
      # else
        session[:user_profile_id] = @user_profile.id
        render json: @user_profile
        # {
        #   user_profile: UserProfileSerializer.new(@user_profile)
        # }
        # flash[:notice] = "Logged in successfully!"
        # redirect_to @user_profile

        # should this be redirect_to Profile.find_by(current_user.user_id) ??
      # end
    else
      render json: { 
        status: 401, 
        error: "Could not authenticate your account"
      }
        # flash.now[:alert] = "There was something wrong with your login details"
        # render 'new'
    end
  end

  def is_logged_in?
    @current_user_profile = UserProfile.find(session[:user_profile_id]) if session[:user_profile_id]
    if @current_user_profile
      render json: {
        logged_in: true,
        user: UserProfileSerializer.new(@current_user_profile)
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  # PATCH/PUT /sessions/1
  # def update
  #   if @session.update(session_params)
  #     render json: @session
  #   else
  #     render json: @session.errors, status: :unprocessable_entity
  #   end
  # end

  def destroy
    session.delete :user_id
    render json: {
      status: 200,
      logged_out: true
    }
      # session[:user_profile_id] = nil
      # flash[:notice] = "Logged out"
      # redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_session
    #   @session = Session.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def session_params
      params.permit!
      # params.require(:user_profile).permit(:email, :password)
      # params.fetch(:session, {})
    end
end
