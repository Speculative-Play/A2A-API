class Api::V1::UserProfilesController < ApplicationController
  before_action :current_account

  # GET /user_profile
  def show
    if !current_user_profile.nil?
      @user_profile = @current_account.user_profile
      render json: @user_profile
    else
      return head(:unauthorized)
    end
  end

  # GET /signup-user
  def new
    puts "render user signup form here"
    return true
  end

  # POST /signup-user
  def create
    @user_profile = UserProfile.new(user_profile_params)
    if @user_profile.save
      render json: {
        status: :created,
        user_profile: @user_profile
      }
    else
      render 'new'
    end
  end

  # PATCH/PUT /user_profile
  def update
    if !current_user_profile.nil?
      @user_profile = @current_user_profile
      puts "user profile id =",@user_profile
      if @user_profile.update(user_profile_params)
        show
      else
        render json: @user_profile.errors, status: :unprocessable_entity
      end
    else
      return head(:unauthorized)
    end
    puts "leaving user_profiles_controller > update"
  end

  # PUT /user_profile/avatar
  def set_avatar
    puts "inside set_avatar"
    if !current_user_profile.nil?
      @current_user = @current_user_profile
      @current_user.avatar.attach(params[:avatar])
      render json: @current_user.avatar
    else
      return head(:unauthorized)
    end
  end

  # DELETE /user_profile
  # def destroy
  #   if !current_user_profile.nil?
  #     @user_profile = @current_user_profile
  #     @user_profile.destroy
  #     log_out
  #     return true
  #   else
  #     return head(:unauthorized)
  #   end
  # end

  # API endpoint for 'api/v1/match' that returns to user their matchmaking category_percentages and top 10 match_profiles via matching algorithm
  def match

    # get list of questions that user answered questions for
    @questions_user_has_answered = []
    Question.find_each do |q|
      if !UserQuestionAnswer.find_by(question_id: q.id).nil?
        @questions_user_has_answered.push(q)
      end
    end

    # get list of matchmaking categories to query (matchmaking_categories that user has answered questions for)
    @match_categories = []
    @questions_user_has_answered.each do |q|
      unless @match_categories.include?(q.matchmaking_category_id)
        @match_categories << q.matchmaking_category_id
      end
    end

    @match_categories_questions_hash = Hash.new
    @match_categories.each do |mc|
      category_questions = []
      @questions_user_has_answered.each do |q|
        if q.matchmaking_category_id == mc
          category_questions << q
        end
      end
      @match_categories_questions_hash[mc] = category_questions
    end



    @matches = Hash.new
    # MatchProfile.find_each do |m|
    MatchProfile.where(id: 1).each do |m|

      # similarity_values = []
      similarity_values = Hash.new

      # value = compare_user_to_match(m.id)
      # value = similarity_value(m.id)
      @match_categories_questions_hash.each {|key, value| similarity_values[key] = similarity_value(value, m.id)}
      @matches[m.id] = similarity_values
    end

    # @results = Hash[@matches.sort_by{|k,v| v}.reverse]
    
    render json: @matches
    # render json: {matches: {scores: @results}}
    # render json: {results: {match_categories_qs: @match_categories_questions_hash, values: @similarity_values}}
  end

  def similarity_index
    # set number of questions answered
    nj = @questions_user_has_answered.count



    puts "match_categories = ", @match_categories

    # @user_question_answers = UserQuestionAnswer.where(user_profile_id: @current_account.user_profile)

    # @match_question_answers = MatchQuestionAnswer.where(match_profile_id: id, )

  end

  def similarity_value(array_of_questions, match_id)
  # def similarity_value(id)

    @match_question_answers = MatchQuestionAnswer.where(match_profile_id: match_id)
    # puts "found this many match_questionAnswers: ", @match_question_answers.count
    @user_question_answers = UserQuestionAnswer.where(user_profile_id: @current_account.user_profile)
    @category_percentages = CategoryPercentage.where(user_profile_id: @current_account.user_profile)

    percentages = []
    @category_percentages.each do |cp|
      percentages.push(cp.category_percentage)
    end

    similarity = 0
    questions_in_common = 0
    @user_question_answers.each do |user_a|
      @match_question_answers.each do |match_a|
        if user_a.question_id == match_a.question_id && array_of_questions.include?(Question.find_by(id: user_a.question_id))
          questions_in_common = questions_in_common + 1
          # check for question_type
          question = Question.find_by(id: user_a.question_id)
          @category_id = question.matchmaking_category_id
          # puts "here is the category_id for this question: ", @category_id
          @multiplier = percentages[(@category_id - 1)]
          # puts "here is the multiplier: ", @multiplier
          # zero-one question type
          if question.question_type == "zero-one"
            # puts "found a zero-one"
            if user_a.answer_id == match_a.answer_id
              similarity = similarity + (1.0 * @multiplier)

            end
          # range question type
          elsif question.question_type == "range"
            # puts "found a range"
            similarity = similarity + (range_question_score(question.id, user_a.answer_id, match_a.answer_id) * @multiplier)
          end

        end
      end
    end
    # puts "similairty = ",similarity
    similarity = similarity / questions_in_common
    # puts "similarty divided = ", similarity
    return similarity
  end

  def range_question_score(q_id, u_a_id, m_a_id)
    answers = Answer.where(question_id: q_id)
    t = answers.count
    d = (u_a_id - m_a_id).abs
    points = (t.to_f - d.to_f) / t.to_f
    return points
  end

  # def join_test
  #   @hash = Hash.new
  #   Question.find_each do |q|
  #     answers = Answer.where(question_id: q.id)
  #     @hash[q.id] = answers
  #   end
  #   render json: @hash
  # end

  # def similarity_value(question_similarity, total_mutual_questions)

  # end

  private
    # Only allow a list of trusted parameters through.
    def user_profile_params
      params.require(:user_profile).permit(:first_name, :last_name, :admin, :avatar)
    end
  
    def pie_params
      params.permit!
      # params.permit(pie_percentages: [:cultureScore, :facialScore, :lifestyleScore, :kundaliScore, :locationScore])
    end

end