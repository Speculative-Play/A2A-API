class Api::V1::UserProfilesController < ApplicationController
  before_action :current_account

  # GET /user_profiles
  def index
    @user_profiles = UserProfile.all
    render json: @user_profiles
  end

  def profiles_root_placeholder
    puts "inside user_profiles_controller > profiles_root_placeholder"
  end

  # GET /user_profiles/1
  def show
    puts "inside user_profiles_controller > show"
    if !current_user_profile.nil?
      @user_profile = @current_account.user_profile
      render json: @user_profile
    else
      render json: "must login first"
    end
  end

  # POST /search-child
  def search_child
    @user_profile = UserProfile.where(email: params[:email])
    render json: @user_profile
  end

  # GET /signup-user
  def new
    render json: "user_profile signup form"
    @user_profile = UserProfile.new
  end

  # POST /user_profiles or /user_profiles.json
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

  # PATCH/PUT /user_profiles/1 or /user_profliles/1.json
  def update
    # puts "inside user_profiles_controller > update"
    # puts "current user profile check =", @current_user_profile
    current_user_profile
    @user_profile = @current_user_profile
    puts "user profile id =",@user_profile
    if @user_profile.update(user_profile_params)
      puts "inside UserProfiles > update > if passed"

      show
      # render 'show', status: :ok
    else
      # puts "inside UserProfiles > update > else taken"

      render json: @user_profile.errors, status: :unprocessable_entity
    end
    puts "leaving user_profiles_controller > update"

  end

  # DELETE /user_profiles/1 or /user_profiles/1.json
  def destroy
    @user_profile = @current_user_profile
    @user_profile.destroy
    render json: "user was deleted."
    # session[:user_profile_id] = nil if @user_profile == current_user_profile
  end

  def correct_user_profile
    @user_profile = UserProfile.find(params[:id])
    # redirect_to(root_url) unless current_user_profile?(@user_profile)
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

    @user_question_answers = UserQuestionAnswer.where(user_profile_id: @current_account.user_profile_id)
    @match_question_answers = MatchQuestionAnswer.where(match_profile_id: 1)
    render json: {all_questions: {user_question_answers: @user_question_answers, match_question_answers: @match_question_answers}}    
  end

end