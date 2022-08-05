class Api::V1::MatchQuestionAnswersController < ApplicationController
  before_action :set_match_question_answer, only: %i[ show update destroy ]

  # GET /match_question_answers
  def index
    @match_question_answers = MatchQuestionAnswer.all

    render json: @match_question_answers
  end

  # GET /match_question_answers/1
  def show
    render json: @match_question_answer
  end

  # POST /match_question_answers
  def create
    @match_question_answer = MatchQuestionAnswer.new(match_question_answer_params)

    if @match_question_answer.save
      render json: @match_question_answer, status: :created, location: @match_question_answer
    else
      render json: @match_question_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /match_question_answers/1
  def update
    if @match_question_answer.update(match_question_answer_params)
      render json: @match_question_answer
    else
      render json: @match_question_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /match_question_answers/1
  def destroy
    @match_question_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_question_answer
      @match_question_answer = MatchQuestionAnswer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_question_answer_params
      params.fetch(:match_question_answer, {})
    end
end
