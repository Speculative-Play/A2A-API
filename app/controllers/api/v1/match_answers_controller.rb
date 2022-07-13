class Api::V1::MatchAnswersController < ApplicationController
  before_action :set_match_answer, only: %i[ show update destroy ]

  # GET /match_answers
  def index
    @match_answers = MatchAnswer.all

    render json: @match_answers
  end

  # GET /match_answers/1
  def show
    render json: @match_answer
  end

  # POST /match_answers
  def create
    @match_answer = MatchAnswer.new(match_answer_params)

    if @match_answer.save
      render json: @match_answer, status: :created, location: @match_answer
    else
      render json: @match_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /match_answers/1
  def update
    if @match_answer.update(match_answer_params)
      render json: @match_answer
    else
      render json: @match_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /match_answers/1
  def destroy
    @match_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_answer
      @match_answer = MatchAnswer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_answer_params
      params.fetch(:match_answer, {})
    end
end
