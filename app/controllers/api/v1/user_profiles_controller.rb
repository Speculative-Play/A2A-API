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
  # def new
  #   puts "inside user new"
  #   render json: "Render user signup form here. Once form is filled, POST to 'signup-user'"
  # end

  # POST /signup-user
  def create
    @user_profile = UserProfile.new(user_profile_params)
    if @user_profile.save
      @account = @current_account
      if @account.update(user_profile_id: @user_profile.id)
        render json: {
          status: :created,
          user_profile: @user_profile
        }
      end
    else
      render 'new'
    end
  end

  # PATCH/PUT /user_profile
  def update
    if !current_user_profile.nil?
      @user_profile = @current_user_profile
      if @user_profile.update(user_profile_params)
        show
      else
        render json: @user_profile.errors, status: :unprocessable_entity
      end
    else
      return head(:unauthorized)
    end
  end

  # PUT /user_profile/avatar
  def set_avatar
    if !current_user_profile.nil?
      @current_user = @current_user_profile
      @current_user.avatar.attach(params[:avatar])
      render json: @current_user.avatar
    else
      return head(:unauthorized)
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_profile_params
      params.require(:user_profile).permit(:first_name, 
                                           :last_name, 
                                           :admin, 
                                           :gender, 
                                           :city, 
                                           :country, 
                                           :birth_country, 
                                           :date_of_birth, 
                                           {:languages => []},
                                           :marital_status, 
                                           :education, 
                                           :occupation, 
                                           :religion, 
                                           :father, 
                                           :mother, 
                                           {:sisters => []}, 
                                           {:brothers => []}, 
                                           {:about_me => []}, 
                                           :avatar)
    end

end