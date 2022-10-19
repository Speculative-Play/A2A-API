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
    @session_email = params[:session][:email]
    @session_password = params[:session][:password]

    if @session_type == 1
      puts "child account found"
      @user_profile = UserProfile.find_by(email: @session_email)
      puts @user_profile
      if @user_profile && @user_profile.authenticate(@session_password)
        log_in_user_profile @user_profile
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
        puts "user could not be authenticated"
      end
    elsif @session_type == 2
      puts "parent account found"
      @parent_account = ParentAccount.find_by(email: @session_email)
      puts @parent_account
      if @parent_account = @parent_account.authenticate(@session_password)
        log_in_parent_account @parent_account
        remember(@parent_account)
        # TODO: Unpermitted parameters error here due to not permitting email and pw 
        # => seems to work fine regardless but note for later to fix
        params = session_database_params.to_h
        params[:account_id] = @parent_account.id
        @session = Session.new(params)
        if @session.save
          render json: @parent_account
        else
          puts "session could not be saved"
          render json: "session error: could not be saved"
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
    # @session = Session.where(a)
    # puts "session = ", @session
    @session_type = params[:session][:session_type]
    puts "session type = ", @session_type

    # if @session_type == 1
    # Session.first.destroy
    # current_parent_account = nil
    # current_user_profile = nil
    # else

    user_profile = @current_user_profile
    puts "current user profile = ", user_profile
    if !current_user_profile.nil?
      puts "user session detected"
    elsif !@current_parent_account.nil?
      puts "parent session detected"
    else
      puts "no session type detected"
    end
    # puts "parent account detected = ", current_parent_account
    # if !current_parent_account.nil?
    if @session_type == 1
      @session = Session.where("account_id = ? AND session_type = ?", @current_user_profile.id, 1)
      
      puts "user profile logout detected"
      puts "user to be logged out = ", @session.id
      @session.destroy
      log_out_user_profile
    # elsif !current_user_profile.nil?
    elsif @session_type == 2

      puts "parent account logout detected"
      log_out_parent_account
    end
    # log_out
    puts "redirecting to root url now..."
    # redirect_to root_url
  end

  private

    def session_database_params
      params.require(:session).permit(:session_type, :account_id)
    end

    # Only allow a list of trusted parameters through.
    def session_params
      puts "inside Sessions > session_params method"
      params.permit(:email, :password, :session_type, :user_profile, :parent_account, :account_id)      # params.require(:user_profile).permit(:email, :password, :account_type)
      # params.fetch(:session, {})
      # puts "leaving Sessions > session_params"
    end
end
