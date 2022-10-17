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
      puts "child account found"
      @user_profile = UserProfile.find_by(email: params[:session][:email])
      puts @user_profile
      if @user_profile && @user_profile.authenticate(params[:session][:password])
        log_in_user_profile @user_profile
        remember(@user_profile) 
        # TODO: Unpermitted parameters error here due to not permitting email and pw 
        # => seems to work fine regardless but note for later to fix
        @session = Session.new(session_database_params)
        if @session.save
          render json: @user_profile
        else
          puts "session could not be saved"
        end
      else
        # TODO: put error message here
        render json: "user could not be authenticated"
        puts "user could not be authenticated"
      end
    elsif @session_type == 2
      @parent_account = ParentAccount.find_by(email: params[:session][:email])
      if @parent_account = @parent_account.authenticate(params[:session][:password])
        log_in_parent_account @parent_account
        remember(@parent_account)
        # TODO: Unpermitted parameters error here due to not permitting email and pw 
        # => seems to work fine regardless but note for later to fix
        @session = Session.new(session_database_params)
        if @session.save
          render json: @parent_account
        else
          puts "session could not be saved"
        end

      else
        # TODO: put error message here
        puts "account could not be authenticated"
      end
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
    # puts "inside sessions_controller > destroy"
    # puts "user account detected = ", @current_user_profile
    @session = Session.first
    puts "session = ", @session
    @session_type = @session[:session_type]
    puts "session type = ", @session_type

    # if @session_type == 1
    # Session.first.destroy
    # current_parent_account = nil
    # current_user_profile = nil
    # else


    # puts "parent account detected = ", current_parent_account
    # if !current_parent_account.nil?
    if @session_type == 2
      puts "parent account logout detected"
      log_out_parent_account
    # elsif !current_user_profile.nil?
    elsif @session_type == 1
      puts "user profile logout detected"
      log_out_user_profile
    end
    # log_out
    puts "redirecting to root url now..."
    # redirect_to root_url
  end

  private

    def session_database_params
      params.require(:session).permit(:session_type)
    end

    # Only allow a list of trusted parameters through.
    def session_params
      puts "inside Sessions > session_params method"
      params.permit(:email, :password, :session_type, :user_profile, :parent_account)      # params.require(:user_profile).permit(:email, :password, :account_type)
      # params.fetch(:session, {})
      # puts "leaving Sessions > session_params"
    end
end
