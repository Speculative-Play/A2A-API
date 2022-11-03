class Api::V1::MatchProfilesController < ApplicationController

  # GET /match_profiles
  def index
    @match_profiles = MatchProfile.all
    render json: @match_profiles
  end

  # GET /match_profiles/1
  def show
    render json: @match_profile
  end

  ### Matchmaking Algorithm Section ###

  # POST /match
  # Returns top 10 match_profiles and corresponding match score
  def match

    # assure account is logged in, else return 401
    if !current_account.nil?

        # check if current logged in account is user or parent, set variables to appropriate user_profile
        if !current_account.user_profile.nil?
            @current_user_profile = @current_account.user_profile
        elsif !current_account.parent_profile.nil?
            parent = @current_account.parent_profile
            @current_user_profile = UserProfile.find_by(id: parent.user_profile_id)
        end

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

        # sort questions into matchmaking_categories hash 
        # {key: matchmaking_category, value: array of questions in that category}
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

        # set t variable for total number of categories
        total_categories = @match_categories.count


        # get user_profile's or parent_profile's matchmaking_category category_percentages
        if !@current_account.user_profile.nil?
          @match_categories_weights = CategoryPercentage.where(user_profile_id: @current_user_profile.id)
        elsif !@current_account.parent_profile.nil?
          @match_categories_weights = CategoryPercentage.where(parent_profile_id: @current_account.parent_profile)
        end


        # execute matching algorithm on every match
        @matches = Hash.new
        MatchProfile.find_each do |m|
          similarity_values = Hash.new
          stored_val = 0
          weighted_sum = 0
          total_similarity_index = 0

          @match_categories_questions_hash.each {|key, value| stored_val = similarity_value(value, m.id); similarity_values[key] = stored_val}
          similarity_values.each_value {|value| total_similarity_index = total_similarity_index + value}
          si_over_total = total_similarity_index / total_categories
          similarity_values.each {|key, value| weighted_sum = weighted_sum + (@match_categories_weights.find_by(matchmaking_category_id: key).category_percentage / 100.0) * value}

          total_match = (si_over_total + weighted_sum) / 2.0
          @matches[m.id] = total_match.round(2)
        end

        @results = Hash[@matches.sort_by{|k,v| v}.reverse]
        @results = Hash[@results.take(10)]

        render json: {match_scores: @results}
    else
        return head(:unauthorized)
    end
  end

  def similarity_value(array_of_questions, match_id)

    @match_question_answers = MatchQuestionAnswer.where(match_profile_id: match_id)
    @user_question_answers = UserQuestionAnswer.where(user_profile_id: @current_user_profile.id)

    similarity = 0
    questions_in_common = 0
    @user_question_answers.each do |user_a|
    @match_question_answers.each do |match_a|
        if user_a.question_id == match_a.question_id && array_of_questions.include?(Question.find_by(id: user_a.question_id))
        questions_in_common = questions_in_common + 1
        # check for question_type
        question = Question.find_by(id: user_a.question_id)
        @category_id = question.matchmaking_category_id
        if question.question_type == "zero-one"
            # puts "found a zero-one"
            if user_a.answer_id == match_a.answer_id
            similarity = similarity + 1.0
            end
        # range question type
        elsif question.question_type == "range"
            similarity = similarity + range_question_score(question.id, user_a.answer_id, match_a.answer_id)
        end

        end
    end
    end
    similarity = similarity / questions_in_common
    return similarity
  end

  def range_question_score(q_id, u_a_id, m_a_id)
    answers = Answer.where(question_id: q_id)
    t = answers.count
    d = (u_a_id - m_a_id).abs
    points = (t.to_f - d.to_f) / t.to_f
    return points
  end

  private
    # Only allow a list of trusted parameters through.
    def match_profile_params
      # params.fetch(:match_profile, {})
      params.require(:match_profile).permit(:first_name, :last_name, :avatar)

    end
end
