class Api::V1::QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show update destroy ]

  # GET /questions
  def index
    @questions = Question.all
    @questions = @questions.sort_by {|prof| prof.matchmaking_category_id}.to_json(include: :answers)
    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # GET /questions/matchmaking_category/1
  def questions_by_category
    questions = if params[:matchmaking_category_id].present?
      Question.where(matchmaking_category_id: params[:matchmaking_category_id])
    end

    questions_answers = Hash.new
    questions.each do|q|
      answers = Answer.where(question_id: q.id)
      questions_answers[q.question_text] = answers.pluck("answer_text")
    end

    render json: questions_answers
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.fetch(:question, {})
    end
end
