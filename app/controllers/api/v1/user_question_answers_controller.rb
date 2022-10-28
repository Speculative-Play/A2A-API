class Api::V1::UserQuestionAnswersController < ApplicationController
  before_action :current_account

  # GET /my_question_answers
  def index
    if !current_user_profile.nil?
      @categories_arr = Hash.new
      MatchmakingCategory.find_each do |match_cat|
        @questions = Question.where(matchmaking_category_id: match_cat.id)
        questions_arr = Hash.new
        @questions.each do |q|
          @answers = Answer.where(question_id: q.id)
          answers_arr = Hash.new
          @answers.each do |a|
            if UserQuestionAnswer.where("question_id = ? AND answer_id = ? AND user_profile_id = ?", q.id, a.id, current_user_profile.id).present?
              answers_arr[a.answer_text] = [1]
            else
              answers_arr[a.answer_text] = [0]
            end
          end
          questions_arr[q.question_text] = [answers_arr]
        end
        @categories_arr[match_cat.category_name] = [questions_arr]
      end
      render json: {user_question_answers: @categories_arr}
    else
      return head(:unauthorized)
    end
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
      # is this what should be returned?
      return false
    end
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
  # Only allow a list of trusted parameters through.
  def user_question_answer_params
    params.fetch(:user_question_answer, {})
  end

end
