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

  # DELETE /user_profile
  def destroy
    if !current_user_profile.nil?
      @user_profile = @current_user_profile
      @user_profile.destroy
      log_out
      return true
    else
      return head(:unauthorized)
    end
  end

  # Only allow a list of trusted parameters through.
  def user_profile_params
    params.require(:user_profile).permit(:first_name, :last_name, :admin, :image)
  end

  def pie_params
    params.permit!
    # params.permit(pie_percentages: [:cultureScore, :facialScore, :lifestyleScore, :kundaliScore, :locationScore])
  end

  # API endpoint for 'api/v1/match' that returns to user their matchmaking category_percentages and top 10 match_profiles via matching algorithm
  def match
    # @matches = Hash.new
    # MatchProfile.find_each do |m|
    #   puts "loop id =", m.id
    #   value = compare_user_to_match(m.id)
    #   @matches[m.first_name] = value
    # end

    join_test
    
    # render json: Hash[@matches.sort_by{|k,v| v}.reverse]
  end

  def similarity_value(id)
    # puts "compare_user_to_match"

    @match_question_answers = MatchQuestionAnswer.where(match_profile_id: id)
    @user_question_answers = UserQuestionAnswer.where(user_profile_id: @current_account.user_profile_id)


    similarity = 0
    @user_question_answers.each do |user_a|
      @match_question_answers.each do |match_a|
        if user_a.question_id == match_a.question_id
          if user_a.answer_id == match_a.answer_id
            similarity = similarity + 1
          else

          end
        end
      end
    end
    puts "similairty = ",similarity
    return similarity
  end

  def join_test
    @hash = Hash.new
    Question.find_each do |q|
      answers = Answer.where(question_id: q.id)
      @hash[q.id] = answers
    end
    render json: @hash
  end

  # def similarity_value(question_similarity, total_mutual_questions)

  # end

end