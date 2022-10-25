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
      session[:account_id] = account.id
      puts "inside sessions_controller > create > passed authentication if"
      log_in account

      if !current_user_profile.nil?
        @user_profile = account.user_profile
        render json: @user_profile
      elsif !current_parent_profile.nil?
        @parent_profile = account.parent_profile
        render json: @parent_profile
      end
      
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
    render json: "now logged out"
    # redirect_to root_url
  end

end
