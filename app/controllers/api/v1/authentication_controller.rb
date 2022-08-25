class Api::V1::AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login

    # POST /auth/login
    def login
      puts "inside authentication controller"
      puts "inside authentication controller"
      puts "inside authentication controller"
      @user_profile = UserProfile.find_by_email(params[:email])
      if @user_profile&.authenticate(params[:password])
        token = JsonWebToken.encode(user_profile_id: @user_profile.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                      status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def login_params
      params.permit(:email, :password)
    end
end
