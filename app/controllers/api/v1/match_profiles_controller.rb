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

  # POST /search-matches
  # Search feature to search match_profiles based on passed attributes
  def search_matches
    # Column filters to search within:
    # Gender 
    if params[:categories][:gender].present?
      matches = MatchProfile.where(gender: params[:categories][:gender])
    end
    # City
    if params[:categories][:city].present?
      matches = matches.where(city: params[:categories][:city])
    end
    # Country
    if params[:categories][:country].present?
      matches = matches.where(country: params[:categories][:country])
    end
    # Birth Country 
    if params[:categories][:birth_country].present?
      matches = matches.where(birth_country: params[:categories][:birth_country])
    end
    # Birthdate Before
    if params[:categories][:birthdate_before].present?
      matches = matches.where("date_of_birth < ?", params[:categories][:birthdate_before])
    end
    # Birthdate After
    if params[:categories][:birthdate_after].present?
      matches = matches.where("date_of_birth > ?", params[:categories][:birthdate_after])
    end
    # Language
    if params[:categories][:language].present?
      matches = matches.where("languages LIKE ?", "%" + params[:categories][:language] + "%" )
    end
    # Marital Status
    if params[:categories][:marital_status].present?
      matches = matches.where(marital_status: params[:categories][:marital_status])
    end
    # Education
    if params[:categories][:education].present?
      matches = matches.where(education: params[:categories][:education])
    end
    # Occupation
    if params[:categories][:occupation].present?
      matches = matches.where(occupation: params[:categories][:occupation])
    end
    # Religion
    if params[:categories][:religion].present?
      matches = matches.where(religion: params[:categories][:religion])
    end

    render json: matches

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

        puts "current user id = ", 
        # get list of questions that user answered questions for
        @questions_user_has_answered = []
        Question.find_each do |q|
          if !UserQuestionAnswer.find_by("question_id = ? AND user_profile_id = ?", q.id, @current_user_profile).nil?
            if UserQuestionAnswer.find_by("question_id = ? AND user_profile_id = ?", q.id, @current_user_profile).matching_algo == true
              @questions_user_has_answered.push(q)
            end
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
        else 
          return 
        end

        # execute matching algorithm on every match
        @matches = Hash.new
        # MatchProfile.find_each do |m|
        MatchProfile.where("id <= ?", 50).each do |m|
          similarity_values = Hash.new
          stored_val = 0
          weighted_sum = 0
          total_similarity_index = 0

          @match_categories_questions_hash.each {|key, value| stored_val = similarity_value(value, m.id); similarity_values[key] = stored_val}
          similarity_values.each_value {|value| total_similarity_index = total_similarity_index + value}
          si_over_total = total_similarity_index / total_categories
          similarity_values.each {|key, value| weighted_sum = weighted_sum + (@match_categories_weights[key - 1].category_percentage / 100.0) * value;}
          total_match = (si_over_total + weighted_sum) / 2.0
          @matches[m.id] = total_match.round(2)
        end

        @results = Hash[@matches.sort_by{|k,v| v}.reverse]

        # Scaled results
        # f(x) = (x - min) / (max - min)

        # min = @results.values[@results.size - 1]
        # max = @results.values.first
        # results_mod = Hash.new
        # @results.each {|key, value| results_mod[key] = (value - min) / (max - min)}

        @results = Hash[@results.take(10)]
        render json: {match_scores: @results}

        # render json: {match_scores: {results: @results, results_mod: results_mod}}
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
    if questions_in_common < 1
      return 0
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
      params.require(:match_profile).permit(:first_name, :last_name, :gender, :city, :country, :birth_country, :date_of_birth, :birthdate_before, :birthdate_after, :languages, :marital_status, :avatar)
    end
end
