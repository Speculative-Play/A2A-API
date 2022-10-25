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
      # params[:session][:remember_me] = 1
      remember account
      @user_profile = account.user_profile
      # @current_user_profile = @user_profile
      # puts "current user = ", @user_profile.id

      # check if a user is already logged in
      # if Session.find_by(account_id: account.id).nil?
      #   # if a user is already logged in, then log out first before logging in new user
      #   puts "someone is already logged in!"
      # end

      # @session = Session.new(account_id: account.id)
      # if @session.save
      #   puts "session was saved to db successfully"
        render json: @user_profile
      # else
      #   puts "session could not be saved"
      #   render json: "session error: could not be saved"
      # end
      
    else
      render 'new'
    end
  end

  def destroy
    puts "inside sessions_controller > destroy"

    # current_account

    # puts "current_account = ", @current_account
    # session = if Session.find_by(account_id: @current_account.id)
    #   session.destroy
    #   puts "destroyed a session"
    # end
    puts "inside sessions_controller > destroy > now will log_out"
    log_out
    # redirect_to root_url
  end

end
