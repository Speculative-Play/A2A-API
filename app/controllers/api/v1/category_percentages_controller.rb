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

    # parse JSON and create variables
    @json = JSON.parse(request.body.read)
    @user_profile_id = params[:user_profile_id] # input user_profile_id
    @input_category_id_array = []               # input matchmaking_category_ids
    @input_category_percentage_array = []       # input category_percentages

    @current_category_percentages = CategoryPercentage.where("user_profile_id = ?", @user_profile_id)

    # collect and store the input values in arrays
    @json['category_percentages_input'].each_with_index do |category, index|
      @input_category_id_array[index] = category['matchmaking_category_id']
      @input_category_percentage_array[index] = category['category_percentage']
    end

    # TODO: need to implement verification that total value of all category_percentages = 100%)

    # update the records with the new values
    @input_category_id_array.each_with_index do |array, index|
      CategoryPercentage.update(@current_category_percentages[index].id, :category_percentage => @input_category_percentage_array[index])
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
      # params.fetch(:category_percentage, {})
      params.permit(:category_percentage, :matchmaking_category_id, :user_profile_id)

    end
end
