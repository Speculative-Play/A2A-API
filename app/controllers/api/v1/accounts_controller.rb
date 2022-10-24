class Api::V1::AccountsController < ApplicationController
    before_action :authenticate_author
  
    # GET /accounts/1
    def show
      # render json: @account
      @account = Account.find(params[:id])
    end

    def new
      @acount = Account.new
    end
  
    # POST /accounts
    def create
      @account = Account.new(account_params)
  
      if @account.save
        redirect_to @account
        # render json: @account, status: :created, location: @account
      else
        render 'new'
        # render json: @account.errors, status: :unprocessable_entity
      end
    end
  
    private
  
      # Only allow a list of trusted parameters through.
      def account_params
        params.require(:account).permit(:email, :password)
      end

      def authenticate_account
        flash[:danger] = "Please log in."
        redirect_to login_url
      end

      def correct_account
        @account = Account.find(params[:id])
        redirect_to(account) unless current_account?(@account)
      end

end