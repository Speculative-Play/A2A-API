class Api::V1::UserQuestionAnswersController < ApplicationController
  before_action :set_user_question_answer, only: %i[ show update destroy ]

  # GET /user_question_answers
  def index
    # IF user_profile_id is present THEN return only user_question_answers with matching user_profile_id
    # @user_question_answers = if params[:user_profile_id].present?
    #   UserQuestionAnswer.where("user_profile_id = ?", params[:user_profile_id])

    # ELSE return ALL user_question_answers
    # else
      # UserQuestionAnswer.all
    # end
    @user_question_answers = UserQuestionAnswer.where("user_profile_id = ?", current_user_profile.id)

    render json: @user_question_answers
  end

  # GET /user_question_answers/1
  def show
    render json: @user_question_answer
  end

  # GET /user_profile/:id/user_question_answer/:id
  def get_individual_user_profile_user_question_answer
    @user_question_answers = UserQuestionAnswer.where("user_profile_id = ?", params[:user_profile_id])
    @@nth = params[:id]
    @@limit = UserQuestionAnswer.where("user_profile_id = ?", params[:user_profile_id]).count()

    if @@nth.to_i < @@limit
      @nth_user = @user_question_answers.limit(@@nth).last

      render json: @nth_user
    else 
      render json: "Error: User_Question_Answer Not Found"
    end
  end

  # GET /user_question_answer/[user_profile_id]
  def get_user_questions_answers
    @user_question_answers = UserQuestionAnswer.where("user_profile_id = ?", params[:user_profile_id])

    @questions = Question.joins(:user_question_answers).where("user_question_answers.user_profile_id" => params[:user_profile_id])

    @answers = Answer.joins(:user_question_answers).where("user_question_answers.user_profile_id" => params[:user_profile_id])

    render json: {all_data: {user_question_answers: @user_question_answers, questions: @questions, answers: @answers}}
    format.json { render :json => @user_question_answers.to_json}
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
