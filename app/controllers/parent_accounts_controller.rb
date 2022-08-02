class ParentAccountsController < ApplicationController
  before_action :set_parent_account, only: %i[ show update destroy ]

  # GET /parent_accounts
  def index
    @parent_accounts = ParentAccount.all

    render json: @parent_accounts
  end

  # GET /parent_accounts/1
  def show
    render json: @parent_account
  end

  # POST /parent_accounts
  def create
    @parent_account = ParentAccount.new(parent_account_params)

    if @parent_account.save
      render json: @parent_account, status: :created, location: @parent_account
    else
      render json: @parent_account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parent_accounts/1
  def update
    if @parent_account.update(parent_account_params)
      render json: @parent_account
    else
      render json: @parent_account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /parent_accounts/1
  def destroy
    @parent_account.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent_account
      @parent_account = ParentAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parent_account_params
      params.fetch(:parent_account, {})
    end
end
