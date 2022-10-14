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
    @session_type = params[:session][:session_type]
    if @session_type == 1
      @user_profile = UserProfile.find_by(email: params[:session][:email])
      if @user_profile && @user_profile.authenticate(params[:session][:password])
        log_in_user_profile @user_profile
        remember(@user_profile) 
        render json: @user_profile
      else
        # TODO: put error message here
        puts "user could not be authenticated"
      end
    elsif @session_type == 2
      @parent_account = ParentAccount.find_by(email: params[:session][:email])
      if @parent_account = @parent_account.authenticate(params[:session][:password])
        log_in_parent_account @parent_account
        remember(@parent_account)
        render json: @parent_account
      else
        # TODO: put error message here
        puts "account could not be authenticated"
      end
      end
    else
      render json: { 
        status: 401, 
        error: "Could not authenticate your account"
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
    if !current_parent_account.nil?
      puts "parent account logout detected"
    elsif !current_user_profile.nil?
      puts "user profile logout detected"
    end
    # log_out
    puts "redirecting to root url now..."
    # redirect_to root_url
  end

  private

    # Only allow a list of trusted parameters through.
    def session_params
      # puts "inside Sessions > session_params method"
      # params.permit!
      params.require(:user_profile).permit(:email, :password, :session_type)
      # params.fetch(:session, {})
      # puts "leaving Sessions > session_params"
    end
end
