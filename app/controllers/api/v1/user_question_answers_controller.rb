class Api::V1::UserQuestionAnswersController < ApplicationController
  before_action :set_user_question_answer, only: %i[ show update destroy ]

  # GET /user_question_answers
  def index
    @user_question_answers = UserQuestionAnswer.all

    render json: @user_question_answers
  end

  # GET /user_question_answers/1
  def show
    render json: @user_question_answer
  end

  # POST /user_question_answers
  def create
    @user_question_answer = UserQuestionAnswer.new(user_question_answer_params)

    if @user_question_answer.save
      render json: @user_question_answer, status: :created, location: @user_question_answer
    else
      render json: @user_question_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_question_answers/1
  def update
    if @user_question_answer.update(user_question_answer_params)
      render json: @user_question_answer
    else
      render json: @user_question_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_question_answers/1
  def destroy
    @user_question_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_question_answer
      @user_question_answer = UserQuestionAnswer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_question_answer_params
      params.fetch(:user_question_answer, {})
    end
end
