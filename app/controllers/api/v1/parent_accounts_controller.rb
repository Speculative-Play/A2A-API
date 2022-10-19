class Api::V1::ParentAccountsController < ApplicationController
  # before_action :set_parent_account, only: %i[ show update destroy ]
  before_action :authenticate_parent_account

  # GET /parent_accounts
  def index
    @parent_accounts = ParentAccount.all

    render json: @parent_accounts
  end

  # GET /parent_accounts/1
  def show
    @parent_account = current_parent_account
    render json: @parent_account
  end

  def view_child
    @user_profile = UserProfile.where("id = ?", @current_parent_account.user_profile_id)
    render json: @user_profile
  end

  # POST /parent_accounts
  def create
    @parent_account = ParentAccount.new(parent_account_params)

    if @parent_account.save
      render json: @parent_account, status: :created
    else
      render json: @parent_account.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parent_accounts/1
  def update
    if @parent_account.update(parent_account_params)
      render json: @parent_account
    else
      render json: @parent_account.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /parent_accounts/1
  def destroy
    @parent_account.destroy
  end

  # private

  def authenticate_parent_account
    puts "inside parent_account > authenticate_parent_account"
    unless logged_in_parent_account?
      # flash[:danger] = "Please log in."
      # redirect_to login_url
      puts "inside parent_account > authenticate_parent_account > unless logged_in? ==  true"
      # redirect_to log_in
    else
      puts "inside parent_account > authenticate_parent_account > login successful!"
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_parent_account
    @parent_account = ParentAccount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def parent_account_params
    # params.fetch(:parent_account, {})
    params.require(:parent_account).permit(:email, :password, :user_profile_id)

  end
end
