class Api::V1::ParentProfilesController < ApplicationController
  before_action :current_account, expect: :search_child

  # GET / view-child
  def view_child
    if !current_parent_profile.nil?
      @parent = @current_account.parent_profile
      @user_profile = UserProfile.find_by(id: @parent.user_profile_id)
      # render json of user_profile biodata here
      render json: "user_profile biodata here"
    else
      render json: "must be logged in as parent"
    end
  end

  def search_child
    @json = JSON.parse(request.body.read)
    @email = @json["email"]
    puts @email
    if @user_profile = UserProfile.find_by(email: @email)
      render json: @user_profile
    else
      render json: "User profile not found. Please try another email address."
    end
  end

  # GET /signup-parent
  def new
    render json: "parent_profile signup form"
    @user_profile = UserProfile.new
  end

  # POST /parent_profiles
  def create
    @parent_profile = ParentProfile.new(parent_profile_params)

    if @parent_profile.save
      # redirect_to login_url
      # redirect_to controller: 'sessions', action: 'login', session_type: 2, session_email: @parent_profile.email, session_password: parent_profile_params[:password]
      render json: @parent_profile, status: :created
    else
      render json: @parent_profile.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parent_profiles/1
  def update
    if @parent_profile.update(parent_profile_params)
      render json: @parent_profile
    else
      render json: @parent_profile.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /parent_profiles/1
  def destroy
    @parent_profile.destroy
  end

  # private

  def authenticate_parent_profile
    puts "inside parent_profile > authenticate_parent_profile"
    unless logged_in_parent_profile?
      # flash[:danger] = "Please log in."
      # redirect_to login_url
      puts "inside parent_profile > authenticate_parent_profile > unless logged_in? ==  true"
      # redirect_to log_in
    else
      puts "inside parent_profile > authenticate_parent_profile > login successful!"
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_parent_profile
    @parent_profile = ParentProfile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def parent_profile_params
    # params.fetch(:parent_profile, {})
    params.permit(:email, :password, :user_profile_id)

  end
end
