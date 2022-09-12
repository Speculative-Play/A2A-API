class Api::V1::CategoryPercentagesController < ApplicationController
  before_action :set_category_percentage, only: %i[ show update destroy ]

  # GET /category_percentages
  def index
    # @category_percentages = CategoryPercentage.all
    @category_percentages = if params[:user_profile_id].present?
      CategoryPercentage.where("user_profile_id = ?", params[:user_profile_id])
    else
      puts "invalid category_percentages"
    end

    render json: @category_percentages
  end

  # GET /category_percentages/1
  def show
    render json: @category_percentage
  end

  # POST /category_percentages
  def create
    @category_percentage = CategoryPercentage.new(category_percentage_params)

    if @category_percentage.save
      render json: @category_percentage, status: :created, location: @category_percentage
    else
      render json: @category_percentage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /category_percentages/1
  def update
    if @category_percentage.update(category_percentage_params)
      render json: @category_percentage
    else
      render json: @category_percentage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /category_percentages/1
  def destroy
    @category_percentage.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_percentage
      @category_percentage = CategoryPercentage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_percentage_params
      params.fetch(:category_percentage, {})
    end
end
