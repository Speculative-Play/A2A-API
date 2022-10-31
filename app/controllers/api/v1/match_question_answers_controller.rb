class Api::V1::MatchQuestionAnswersController < ApplicationController
  before_action :set_match_question_answer, only: %i[ show update destroy ]

  # GET /match_question_answers
  def index
    # IF match_profile_id is present THEN return only match_question_answers with matching match_profile_id
    @match_question_answers = if params[:match_profile_id].present?
      MatchQuestionAnswer.where("match_profile_id = ?", params[:match_profile_id])
    # ELSE return ALL user_question_answers
    else
      MatchQuestionAnswer.all
    end
    
    render json: @match_question_answers
  end

  # GET /match_question_answers/1
  def show
    render json: @match_question_answer
  end

  def get_individual_match_profile_match_question_answer
    @match_question_answers = MatchQuestionAnswer.where("match_profile_id = ?", params[:match_profile_id])
    @@nth = params[:id]
    @@limit = MatchQuestionAnswer.where("match_profile_id = ?", params[:match_profile_id]).count()

    if @@nth.to_i < @@limit
      @nth_match = @match_question_answers.limit(@@nth).last

      render json: @nth_match
    else 
      render json: "Error: User_Question_Answer Not Found"
    end
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
    # Only allow a list of trusted parameters through.
    def match_question_answer_params
      params.fetch(:match_question_answer, {})
    end
end
