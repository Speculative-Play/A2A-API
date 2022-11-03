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