class Api::V1::ParentProfilesController < ApplicationController
  before_action :authenticate_parent_profile, except: :search_child

  # GET /parent_profiles
  def index
    @parent_profiles = ParentProfile.all

    render json: @parent_profiles
  end

  # GET /parent_profiles/1
  def show
    @parent_profile = current_parent_profile
    render json: @parent_profile
  end

  def view_child
    @user_profile = UserProfile.where("id = ?", @current_parent_profile.user_profile_id)
    render json: @user_profile
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

  # POST /parent_profiles
  def create
    @parent_profile = ParentProfile.new(parent_profile_params)

    if @parent_profile.save
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
    params.require(:parent_profile).permit(:email, :password, :user_profile_id)

  end
end
