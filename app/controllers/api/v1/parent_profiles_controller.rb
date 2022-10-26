class Api::V1::ParentProfilesController < ApplicationController
  before_action :current_account, except: [:search_child, :create]

  # GET / view-child
  def view_child
    if !current_parent_profile.nil?
      @parent = @current_account.parent_profile
      @user_profile = UserProfile.find_by(id: @parent.user_profile_id)
      # render json of user_profile biodata here
    else
      return head(:unauthorized)
    end
  end

  def search_child
    if Account.exists?(email: params[:parent_profile][:child_email])
      if !Account.find_by(email: params[:parent_profile][:child_email]).user_profile.nil?
        return true
      else
        return false
      end
    else
      return false
    end
  end

  # GET /signup-parent
  def new
    render json: "parent_profile signup form"
    @user_profile = UserProfile.new
  end

  # POST /parent_profiles
  def create
    if search_child == true
      @parent_profile = ParentProfile.new(user_profile_id: params[:parent_profile][:child_email])
      @parent_profile.user_profile = UserProfile.find_by(id: Account.find_by(email: params[:parent_profile][:child_email]).user_profile_id)
      if @parent_profile.save
        render @parent_profile
      else
        render json: @parent_profile.errors, status: :unprocessable_entity
      end
    else
      render json: "could not locate child profile"
    end
  end
      
    
    # @parent_profile.user_profile_id = child_profile.id

    # if @parent_profile.save
    #   # redirect_to login_url
    #   # redirect_to controller: 'sessions', action: 'login', session_type: 2, session_email: @parent_profile.email, session_password: parent_profile_params[:password]
    #   render json: @parent_profile, status: :created
    # else
    #   render json: @parent_profile.errors.full_messages, status: :unprocessable_entity
    # end
  # end

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

  # Only allow a list of trusted parameters through.
  def parent_profile_params
    params.require(:parent_profile).permit(:child_email)
  end
end
