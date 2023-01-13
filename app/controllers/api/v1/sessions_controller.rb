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
    if params[:session].present?
      account = Account.find_by(email: params[:session][:email].downcase)
    elsif params[:account].present?
      account = Account.find_by(email: params[:account][:email].downcase)
      params[:session][:email] = params[:account][:email]
      params[:session][:password] = params[:account][:password]
    end
    # if !account.nil?
    if account && account.authenticate(params[:session][:password])
      session[:account_id] = account.id
      log_in account

      if !current_user_profile.nil?
        @user_profile = account.user_profile
        render json: @user_profile
      elsif !current_parent_profile.nil?
        @parent_profile = account.parent_profile
        render json: @parent_profile
      else
        render json: account
      end
    
    else
      return head(:unauthorized)
    end
    # end
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
