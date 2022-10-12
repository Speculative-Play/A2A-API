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
    puts "inside Sessions > new"
  end

  # Creates session object that allows user_profile to be logged in persistently
  def create
    # puts "inside Sessions > create"
    @user_profile = UserProfile.find_by(email: params[:session][:email])
    # puts "inside Sessions > create > @user_profile found = ", @user_profile.email
    if @user_profile && @user_profile.authenticate(params[:session][:password_digest])
      # puts "inside Sessions > create > if user_profile.authenticate[session, password] == true"

      # if user_profile.admin == 1
      #   redirect_to user_profiles_url, notice: "Logged in as ADMIN!"
      # else
      log_in @user_profile

      # if params[:session][:remember_me] == '1'
        # puts "inside Sessions > create > if params[session, remember_me] == 1"

        remember(@user_profile) 
      # else 
        # puts "inside Sessions > create > if params[session, remember_me] != 1"

        # forget(@user_profile)
      # end
      # session[:user_profile_id] = @user_profile.id
      render json: @user_profile

    else
      # render json: { 
      #   status: 401, 
      #   error: "Could not authenticate your account"
      # }
      # puts "inside Sessions > create > user could not be logged in"
      render :new
    end
    # puts "leaving Sessions > create"
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
    log_out
    redirect_to root_url
  end

  private

    # Only allow a list of trusted parameters through.
    def session_params
      # puts "inside Sessions > session_params method"
      # params.permit!
      params.require(:user_profile).permit(:email, :password_digest)
      # params.fetch(:session, {})
      # puts "leaving Sessions > session_params"
    end
end
