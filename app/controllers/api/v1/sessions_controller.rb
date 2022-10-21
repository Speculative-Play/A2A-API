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

    puts "inside session_controller > create"
    @session_type = params[:session_type]
    @session_email = params[:email]
    @session_password = params[:password]

    if !session[:id].nil?
      puts "there is already a user logged in"
    else
      puts "no other user logged in"
      puts session[:id]
    end

    if @session_type == 1
      puts "session#create > creating user account"
      puts "session[:email} = ", @session_email
      @user_profile = UserProfile.where(email: @session_email).take
      puts "user profile to login =", @user_profile.id
      if Account.exists?(user_profile_id: @user_profile.id)
        @account = Account.where(user_profile_id: @user_profile.id).take
      else
        @account = Account.create(:user_profile_id => @user_profile.id, account_type: 1)
      end
      log_in @account
      remember @user_profile
      params = session_database_params.to_h
      params[:account_id] = @account.id
      @session = Session.new(params)
      if @session.save
        render json: @user_profile
      else
        puts "session could not be saved"
        render json: "session error: could not be saved"
      end
    elsif @session_type == 2
      puts "session#create > creating parent account"
      @parent_profile = ParentProfile.where(email: @session_email).take
      if Account.where(:parent_profile_id, @parent_profile.id).present?
        @account = Account.where(:parent_profile_id, @parent_profile.id)
      else
        @account = Account.create(:parent_profile_id => @parent_profile.id, account_type: 2)
      end
      log_in @account
      remember @parent_profile
      params = session_database_params.to_h
      params[:account_id] = @account.id
      @session = Session.new(params)
      if @session.save
        render json: @parent_profile
      else
        puts "session could not be saved"
        render json: "session error: could not be saved"
      end
    else
      puts "could not determine session type"
    end
    puts "leaving Sessions > create"
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

    @session = Session.where("account_id = ?", session[:account_id]).take
    puts "curent session = ", @session.id
    if !@session.nil?
      if @session.session_type == 1
        puts "child log out detected"
        log_out_user_profile
      elsif @session.session_type == 2
        puts "parent log out detected"
        log_out_parent_profile
      else
        puts "log out session type not determined"
      end
      render json: "you are now logged out."

    else
      render json: "you are already logged out."
    end

    # log_out
    # puts "inside sessions_controller > destroy"
    # puts "user account detected = ", @current_user_profile
    # @session = Session.where(a)
    # puts "session = ", @session
    # @session_type = session_params[:session_type]
    # puts "session type = ", @session_type

    # if @session_type == 1
    # Session.first.destroy
    # current_parent_profile = nil
    # current_user_profile = nil
    # else

    # user_profile = @current_user_profile
    # parent_profile = @current_parent_profile
    # puts "current user profile = ", user_profile
    # puts "current parent account =", parent_profile
    # if !user_profile.nil?
    #   puts "user session detected"
    # elsif !@current_parent_profile.nil?
    #   puts "parent session detected"
    # else
    #   puts "no session type detected"
    # end
    # # puts "parent account detected = ", current_parent_profile
    # # if !current_parent_profile.nil?
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
    #   log_out_parent_profile
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
      params.permit(:email, :password, :session_type, :user_profile, :parent_profile, :account_id)

      # puts "leaving Sessions > session_params"
    end

    def authenticate_account
      puts "inside sessions_controller > authenticate_account"
      if !logged_in_user_profile?
        puts "logged_in_user_profile? == false"
        render json: 'You are not logged in! Please log in to continue.', status: :unprocessable_entity
      elsif !logged_in_parent_profile?
        puts "logged_in_parent_profile? == false"
        render json: 'You are not logged in! Please log in to continue.', status: :unprocessable_entity
      end
      puts "leaving sessions_controller >> authenticate_account"
    end
end
