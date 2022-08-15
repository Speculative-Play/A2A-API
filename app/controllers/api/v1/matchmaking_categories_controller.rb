class Api::V1::MatchmakingCategoriesController < ApplicationController
  before_action :set_matchmaking_category, only: %i[ show update destroy ]

  # GET /matchmaking_categories
  def index
    @matchmaking_categories = MatchmakingCategory.all

    render json: @matchmaking_categories
  end

  # GET /matchmaking_categories/1
  def show
    render json: @matchmaking_category
  end

  # POST /matchmaking_categories
  def create
    @matchmaking_category = MatchmakingCategory.new(matchmaking_category_params)

    if @matchmaking_category.save
      render json: @matchmaking_category, status: :created, location: @matchmaking_category
    else
      render json: @matchmaking_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matchmaking_categories/1
  def update
    if @matchmaking_category.update(matchmaking_category_params)
      render json: @matchmaking_category
    else
      render json: @matchmaking_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matchmaking_categories/1
  def destroy
    @matchmaking_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matchmaking_category
      @matchmaking_category = MatchmakingCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def matchmaking_category_params
      params.fetch(:matchmaking_category, {})
    end
end
