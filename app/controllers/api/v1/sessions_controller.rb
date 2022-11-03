class Api::V1::SessionsController < ApplicationController
include ActionController::Cookies
# before_action :authenticate_account, only: :destroy

  def new
    puts "inside Sessions > new"
    return true
  end

  # Creates session object that allows user_profile to be logged in persistently
  def create
    # post the form
    account = Account.find_by(email: params[:session][:email].downcase)
    if !account.nil?
      if account && account.authenticate(params[:session][:password])
        session[:account_id] = account.id
        log_in account

        if !current_user_profile.nil?
          @user_profile = account.user_profile
          render json: @user_profile
        elsif !current_parent_profile.nil?
          @parent_profile = account.parent_profile
          render json: @parent_profile
        end
      
      else
        new
      end
    else
      new
    end
  end

  def destroy
    if !current_account.nil?
      log_out
    end
    # return true
    render :nothing => true, :status => 204 and return
    # redirect_to root_url
  end

end
