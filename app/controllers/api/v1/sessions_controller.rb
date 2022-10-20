class Api::V1::SessionsController < ApplicationController
include ActionController::Cookies
# before_action :authenticate_account, only: :destroy

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

    @session_type = params[:session_type]
    @session_email = params[:email]
    @session_password = params[:password]

    if @session_type == 1
      puts "child account found"
      @user_profile = UserProfile.find_by(email: @session_email)
      puts @user_profile
      if @user_profile && @user_profile.authenticate(@session_password)
        log_in @user_profile
        remember(@user_profile) 
        # TODO: Unpermitted parameters error here due to not permitting email and pw 
        # => seems to work fine regardless but note for later to fix
        params = session_database_params.to_h
        params[:account_id] = @user_profile.id
        @session = Session.new(params)
        if @session.save
          render json: @user_profile
        else
          puts "session could not be saved"
          render json: "session error: could not be saved"
        end
      else
        # TODO: put error message here
        render json: "user could not be authenticated"
        # puts "user could not be authenticated"
      end
    elsif @session_type == 2
      puts "parent account found"
      @parent_account = ParentAccount.find_by(email: @session_email)
      puts @parent_account
      if @parent_account = @parent_account.authenticate(@session_password)
        log_in @parent_account
        remember(@parent_account)
        # TODO: Unpermitted parameters error here due to not permitting email and pw 
        # => seems to work fine regardless but note for later to fix
        params = session_database_params.to_h
        params[:account_id] = @parent_account.id
        @session = Session.new(params)
        if @session.save
          render json: @parent_account
        else
          # puts "session could not be saved"
          render json: "session error: could not be saved"
        end

      else
        # TODO: put error message here
        render json: "parent account could not be authenticated"
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
    log_out
    render json: "you are now logged out."
    # puts "inside sessions_controller > destroy"
    # puts "user account detected = ", @current_user_profile
    # @session = Session.where(a)
    # puts "session = ", @session
    # @session_type = session_params[:session_type]
    # puts "session type = ", @session_type

    # if @session_type == 1
    # Session.first.destroy
    # current_parent_account = nil
    # current_user_profile = nil
    # else

    # user_profile = @current_user_profile
    # parent_account = @current_parent_account
    # puts "current user profile = ", user_profile
    # puts "current parent account =", parent_account
    # if !user_profile.nil?
    #   puts "user session detected"
    # elsif !@current_parent_account.nil?
    #   puts "parent session detected"
    # else
    #   puts "no session type detected"
    # end
    # # puts "parent account detected = ", current_parent_account
    # # if !current_parent_account.nil?
    # if !user_profile.nil?
    #   puts "user_profile.id = ", user_profile.id
    #   session_type = 1
    #   puts "session type = ", session_type
    #   @session = Session.where(session_type: session_type, account_id: user_profile.id)
      
    #   puts "user profile logout detected"
    #   puts "session to be logged out = ", @session
    #   @session.destroy
    #   log_out_user_profile
    # # elsif !current_user_profile.nil?
    # elsif @session_type == 2

    #   puts "parent account logout detected"
    #   log_out_parent_account
    # end
    # # log_out
    # puts "redirecting to root url now..."
    # # redirect_to root_url
  end

  private

    def session_database_params
      params.require(:session).permit(:session_type, :account_id)
    end

    # Only allow a list of trusted parameters through.
    def session_params
      puts "inside Sessions > session_params method"
      params.fetch(:session, {})
      params.permit(:email, :password, :session_type, :user_profile, :parent_account, :account_id)

      # puts "leaving Sessions > session_params"
    end

    def authenticate_account
      puts "inside sessions_controller > authenticate_account"
      if !logged_in_user_profile?
        puts "logged_in_user_profile? == false"
        render json: 'You are not logged in! Please log in to continue.', status: :unprocessable_entity
      elsif !logged_in_parent_account?
        puts "logged_in_parent_account? == false"
        render json: 'You are not logged in! Please log in to continue.', status: :unprocessable_entity
      end
      puts "leaving sessions_controller >> authenticate_account"
    end
end
