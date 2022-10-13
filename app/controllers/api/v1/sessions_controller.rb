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

    @json = JSON.parse(request.body.read)
    @account_type = @json["session"]["account_type"]
    if @account_type == 1
      puts "child account found"
      @user_profile = UserProfile.find_by(email: params[:session][:email])
      if @user_profile && @user_profile.authenticate(params[:session][:password])
        log_in @user_profile
        remember(@user_profile) 
        render json: @user_profile
      else
        # TODO: put error message here
        puts "user could not be authenticated"
      end
    elsif @account_type == 2
      puts "parent account found"
      @parent_account = ParentAccount.find_by(email: params[:session[:email]])
      puts "parent_account found = ", @parent_account
    else
      render json: { 
        status: 401, 
        error: "Could not authenticate your account"
      }
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
    puts "redirecting to root url now..."
    # redirect_to root_url
  end

  private

    # Only allow a list of trusted parameters through.
    def session_params
      # puts "inside Sessions > session_params method"
      # params.permit!
      params.require(:user_profile).permit(:email, :password, :account_type)
      # params.fetch(:session, {})
      # puts "leaving Sessions > session_params"
    end
end
