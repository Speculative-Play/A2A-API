class Api::V1::AccountsController < ApplicationController
    # before_action :

    def new
      # display account signup form here
      @acount = Account.new
    end
  
    # POST /accounts
    def create
      # receive signup form here
      @account = Account.new(account_params)
  
      if @account.save
        if account_params[:account_type] == "user"
          redirect_to controller: :user_profiles, action: :new 
        elsif account_params[:account_type] == "parent"
          puts "account created > parent profile to be created"
        else
          puts "neither type of account created"
        end
      else
        render json: @account.errors, status: :unprocessable_entity
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

      def correct_account
        @account = Account.find(params[:id])
        redirect_to(account) unless current_account?(@account)
      end

end