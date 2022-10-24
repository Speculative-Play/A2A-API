class Api::V1::SessionsController < ApplicationController
include ActionController::Cookies
# before_action :authenticate_account, only: :destroy

  def new
    puts "inside Sessions > new"
    # see login form
  end

  # Creates session object that allows user_profile to be logged in persistently
  def create
    # post the form
    puts "inside Sessions_controller > create"
    account = Account.find_by(email: params[:session][:email].downcase)
    if account && account.authenticate(params[:session][:password])
      puts "inside sessions_controller > create > passed authentication if"
      log_in account
      params[:session][:remember_me] = 1
      @user_profile = account.user_profile
      @current_user_profile = @user_profile
      puts "current user = ", @user_profile.id
      render json: @user_profile
      # render json: "your account was authenticated"
      # redirect_to account
    else
      render 'new'
    end
  end

  def destroy
    log_out
    # redirect_to root_url
  end

end
