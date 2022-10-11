module SessionsHelper
    def log_in(user_profile)
        session[:user_profile_id] = user_profile.id
    end

    def current_user_profile
        @current_user_profile ||= UserProfile.find_by(id: session[:user_profile_id]) if session[:user_profile_id] 
    end

    def logged_in?
        !current_user_profile.nil?
    end

    def log_out
        session.delete(:user_profile_id)
        @current_user_profile = nil
    end

    def current_user_profile?(user_profile)
        user_profile = current_user_profile
    end
end