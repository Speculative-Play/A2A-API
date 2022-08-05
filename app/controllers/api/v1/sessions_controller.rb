class Api::V1::SessionsController < ApplicationController
  before_action :set_session, only: %i[ show update destroy ]

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
    user_profile = UserProfile.find_by(username: params[:session][:username].downcase)

    if user_profile && user_profile.authenicate(params[:session][:password])
      if user_profile.admin == 1
        redirect_to user_profiles_url, notice: "Logged in as ADMIN!"
      else
        session[:user_profile_id] = user_profile.id
        flash[:notice] = "Logged in successfully!"
        redirect_to user_profile
        # should this be redirect_to Profile.find_by(current_user.user_id) ??
      end
    else
        flash.now[:alert] = "There was something wrong with your login details"
        render 'new'
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
      session[:user_profile_id] = nil
      flash[:notice] = "Logged out"
      redirect_to root_path
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_session
  #     @session = Session.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def session_params
  #     params.fetch(:session, {})
  #   end
end
