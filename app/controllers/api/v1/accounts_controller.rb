class Api::V1::AccountsController < ApplicationController
  before_action :current_account, only: [:destroy, :show]

  # GET /signup
  def new
    # display account signup form here
    render json: "display account signup form here"
  end

  # GET /account
  def show
    if !current_account.nil?
      render json: @current_account 
    else
      return head(:unauthorized)
    end
  end

  # POST /signup
  def create
    # receive signup form here
    @account = Account.new(account_params)
    puts "account new passed"
    if @account.save
      if account_params[:account_type] == "user"
        # render json: {
        #   status: :created,
        #   account: @account
        # }
        redirect_to controller: :sessions, action: :create

      elsif account_params[:account_type] == "parent"
        redirect_to controller: :parent_profiles, action: :new 
      end
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /delete-account
  def destroy
    if !current_user_profile.nil?
      @user_profile = @current_user_profile
      @user_profile.destroy
      log_out
      return true
    elsif !current_parent_profile.nil?
      @parent_profile = @current_parent_profile
      @parent_profile.destroy
      log_out
      return true
    else
      return head(:unauthorized)
    end
  end

    private
      # Only allow a list of trusted parameters through.
      def account_params
        params.require(:account).permit(:email, :password, :account_type)
      end

      # def authenticate_account
      #   flash[:danger] = "Please log in."
      #   redirect_to login_url
      # end

      # def correct_account
      #   @account = Account.find(params[:id])
      #   redirect_to(account) unless current_account?(@account)
      # end

end