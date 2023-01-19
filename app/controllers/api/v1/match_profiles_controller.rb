require 'pp'
class Api::V1::MatchProfilesController < ApplicationController
  before_action :current_account



  # GET /match_profiles
  def index
    @match_profiles = MatchProfile.all
    render json: @match_profiles
  end

  # GET /match_profiles/1
  def show
    @match_profile = MatchProfile.find_by(params[:id])
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
            @match_categories_weights = CategoryPercentage.where(user_profile_id: @current_user_profile.id)
        elsif !current_account.parent_profile.nil?
            parent = @current_account.parent_profile
            @current_user_profile = UserProfile.find_by(id: parent.user_profile_id)
            @match_categories_weights = CategoryPercentage.where(parent_profile_id: @current_account.parent_profile)
        end

        # get list of questions that user answered questions for
        @questions_user_has_answered = Question.where(id: (UserQuestionAnswer.where(user_profile_id: @current_user_profile.id).select("question_id")))
        puts "check before! questions user has answered = ", @questions_user_has_answered.count
        
        @match_categories = []
        # get list of user_question_answers
        @user_question_answers = UserQuestionAnswer.where(user_profile_id: @current_user_profile.id)

        # get list of match_categories that contain questions user has answered
        @match_categories = MatchmakingCategory.where(id: (@questions_user_has_answered.select("matchmaking_category_id")))
        puts "list of categories check = ", @match_categories.count

        # create hash that pairs together matchmaking categories, 
        # questions which user has answered, 
        # and corresponding user_question_answers
        # Hash { key: mathcmaking_catgory_id | value: Hash { key: question_id | value: user_question_answer_id }}
        @match_categories_questions_hash = Hash.new
        @user_responses_hash = Hash.new { |h, k| h[k] = h.dup.clear}
        @user_question_answers_hash = Hash.new
        @questions_user_has_answered.each do |question|
          question_id = question.id
          category_id = MatchmakingCategory.find_by(id: question.matchmaking_category_id).id
          question_answer_id = UserQuestionAnswer.where(question_id: question_id).where(user_profile_id: @current_user_profile.id).pick(:id)
          # @user_question_answers_hash[]
          @user_responses_hash[category_id][question_id] = question_answer_id
          # (@match_categories_questions_hash[category_id] ||= []) << 
        end

        # puts "here's the final double hash:"
        # pp @user_responses_hash
        

        # set t variable for total number of categories
        total_categories = @match_categories.count

        # puts "user has answered number of questions: ", @questions_user_has_answered.count
        # puts "the number of match categories considered is:"
        puts total_categories
        # puts "keys in @match_categories_questions_hash = ", @match_categories_questions_hash.keys
        # puts "q_a's in user_questions_answers = ", @user_question_answers.count

        # execute matching algorithm on every match
        @matches = Hash.new
        # MatchProfile.find_each do |match_profile|
        MatchProfile.where("id <= ?", 200).each do |match_profile|
          # puts "now comparing match_id ", match_profile.id
          similarity_values_hash = Hash.new
          stored_val = 0
          weighted_sum = 0
          total_similarity_index = 0
          # puts "match_category_questions = ", @match_categories_questions_hash

          # @match_categories_questions_hash.each { |key, value| 
          #   stored_val = similarity_value(value, match_profile.id); 
          #   similarity_values[key] = stored_val }
          @user_responses_hash.each { |key, value|
            stored_val = similarity_value(value, match_profile.id);
            # puts "stored val = ", stored_val;
            similarity_values_hash[key] = stored_val}

            # return
          similarity_values_hash.each_value {|value| total_similarity_index += value}

          si_over_total = total_similarity_index / total_categories
          # puts "match category weights = ",@match_categories_weights[0].category_percentage


          # similarity_values.each {|key, value| puts "start iterate"; weighted_sum = weighted_sum + (@match_categories_weights[key - 1].category_percentage / 100.0) * value;}
          # TODO: fix this below to better iteration
          i = 0
          similarity_values_hash.each {|key, value| weighted_sum = weighted_sum + ((@match_categories_weights[i].category_percentage) / 100.0) * value; i = i+1}

          
          total_match = (si_over_total + weighted_sum) / 2.0
          
          @matches[match_profile.id] = total_match.round(2)
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

  def similarity_value(user_question_answers_hash, match_id)
    # puts "now doing similarity_value function for match_id ", match_id
    # puts "with questions: ", array_of_questions

    # check which question_answers user and match have entries in common (check by questions in x category?)
    @match_qs = MatchQuestionAnswer.where(match_profile_id: match_id).pluck(:question_id)
    questions_in_common = 0
    match_qa_in_common = []
    user_question_answers_hash.each { |key, value| 
      if key.in?(@match_qs) 
        questions_in_common +=1
        match_qa_in_common << MatchQuestionAnswer.where(match_profile_id: match_id).where(question_id: key).limit(1)
      end
    }

    # compare answers

    similarity = 0
    # puts "questions in common ", questions_in_common    
    # puts "match qa in common ", match_qa_in_common

    # for i in 0..array_of_user_question_answers.count - 1
    #   # puts" at i = "
    #   # puts array_of_user_question_answers[i]
    #       # match_qa_in_common << MatchQuestionAnswer.where(match_profile_id: match_id).where(array_of_user_question_answers.select("question_id")))
    #   match_qa_in_common << MatchQuestionAnswer.where(match_profile_id: match_id).where(question_id: array_of_user_question_answers[i].question_id)

    # end
    # @match_categories = MatchmakingCategory.where(id: (@questions_user_has_answered.select("matchmaking_category_id")))

    # puts "match qa in common = ", match_qa_in_common.count
    # return
  # end
    user_question_answers_hash.each do |key, value|
      # puts "VALUE = ", value
      question = Question.find_by(id: key)
      # if !@match_question_answers.include?(MatchQuestionAnswer.find_by(question_id: question.id))
      #   next
      # else
      #   print "will do match on user_question_answer ", user_a.id
      #   puts
      # end
      match_a = MatchQuestionAnswer.find_by("match_profile_id = ? AND question_id = ?", match_id, question.id)
      user_a = UserQuestionAnswer.find_by(id: value)
      # @match_question_answers.each do |match_a|
        # if user_a.question_id == match_a.question_id && array_of_questions.include?(Question.find_by(id: user_a.question_id))
          # check for question_type
      @category_id = question.matchmaking_category_id
      if question.question_type == "zero-one"
        if user_a.answer_id == match_a.answer_id
        similarity = similarity + 1.0
        end
      # range question type
      elsif question.question_type == "range"
        similarity = similarity + range_question_score(question.id, user_a.answer_id, match_a.answer_id)
      # mirror question type
      elsif question.question_type == "mirror-A"
        
        partner_category_id = MatchmakingCategory.find_by(category_name: "partner traits").id
        mirror_questions = Question.where(matchmaking_category_id: partner_category_id)
        # puts "mirror q's:", mirror_questions
      else
        next
      end

      questions_in_common = questions_in_common + 1
        # end
    end
    # end
    if questions_in_common < 1
      # puts "return 0 > 0 questions in common"
      return 0
    end
    similarity = similarity / questions_in_common
    # puts "return similarity value: ", similarity
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
      params.require(:match_profile).permit(:first_name, :last_name, :gender, :city, :country, :birth_country, :date_of_birth, :birthdate_before, :birthdate_after, :languages, :marital_status, :education, :occupation, :religion, :father, :mother, :sisters, :brothers, :about_me, :avatar)
    end
end
