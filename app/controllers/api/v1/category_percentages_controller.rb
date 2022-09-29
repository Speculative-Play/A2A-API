class Api::V1::CategoryPercentagesController < ApplicationController
  before_action :set_category_percentage, only: %i[ show destroy ]

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

  # PATCH/PUT /category_percentages
  def update
    # @category_percentage = if params[:user_profile_id].present?
    #   # if params[:matchmaking_category_id].present?
    #   if params.has_key?(:matchmaking_category_id)
    #     puts "matchmaking cat id present!"
    #     puts params[:matchmaking_category_id]
    #     puts "did you see it?"
    #   end
      # puts "matchmaking_category_id present"
      # puts "here are params:"
      # puts @category_percentage.user_profile_id
      # puts @category_percentage.id
      # puts @category_percentage.matchmaking_category_id
      # puts @category_percentage.category_percentage
      # CategoryPercentage.where("category_percentage = ?", params[:category_percentage])

      # CategoryPercentage.where("user_profile_id = ? AND matchmaking_category_id = ?", params[:user_profile_id], params[:matchmaking_category_id])
      # puts "category perc = ", CategoryPercentage.where("user_profile_id = ? AND matchmaking_category_id = ?", params[:user_profile_id], params[:matchmaking_category_id])

      if @category_percentage.update(category_percentage_params)
        puts "success!"
        render json: @category_percentage
      else
        puts "fail!"
        render json: @category_percentage.errors, status: :unprocessable_entity
      end
    # else
    #   puts "ERROR"
    # end
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
      # params.fetch(:category_percentage, {})
      params.permit(:category_percentage, :matchmaking_category_id, :user_profile_id)

    end
end
