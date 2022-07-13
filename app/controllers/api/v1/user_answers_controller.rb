class Api::V1::UserAnswersController < ApplicationController
  before_action :set_user_answer, only: %i[ show update destroy ]

  # GET /user_answers
  def index
    @user_answers = UserAnswer.all

    render json: @user_answers
  end

  # GET /user_answers/1
  def show
    render json: @user_answer
  end

  # POST /user_answers
  def create
    @user_answer = UserAnswer.new(user_answer_params)

    if @user_answer.save
      render json: @user_answer, status: :created, location: @user_answer
    else
      render json: @user_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_answers/1
  def update
    if @user_answer.update(user_answer_params)
      render json: @user_answer
    else
      render json: @user_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_answers/1
  def destroy
    @user_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_answer
      @user_answer = UserAnswer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_answer_params
      params.fetch(:user_answer, {})
    end
end
