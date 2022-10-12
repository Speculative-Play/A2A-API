module SessionsHelper
    def log_in(user_profile)
        puts "inside SessionHelper > log_in"
        session[:user_profile_id] = user_profile.id
    end

    def current_user_profile
        puts "inside SessionsHelper > current_user_profile"
        # @current_user_profile ||= UserProfile.find(session[:user_profile_id]) if session[:user_profile_id] 
        if (user_profile_id = session[:user_profile_id])
            @current_user_profile ||= UserProfile.find_by(id: user_profile_id)
            puts "first SessionsHelper > current_user_profile if passed"
            puts "current_user_profile = ", @current_user_profile.id
        elsif (user_profile_id = cookies.signed(:user_profile_id))
            user_profile = UserProfile.find_by(id: user_profile_id)
            if user_profile && user_profile.authenticated?(cookies[:remember_token])
                log_in user_profile
                @current_user_profile = user_profile
            end
        end
        puts "leaving SessionsHelper > current_user_profile"
    end

    def logged_in?
        puts "inside SessionHelper > logged_in?"
        !current_user_profile.nil?
    end

    def log_out
        puts "inside SessionHelper > log_out"
        session.delete(:user_profile_id)
        @current_user_profile = nil
    end

    def current_user_profile?(user_profile)
        puts "inside SessionHelper > current_user_profile?"
        user_profile = current_user_profile
    end

    # Make the user_profile's session permanent
    def remember(user_profile)
        puts "inside SessionHelper > remember(user_profile)"

        user_profile.remember
        cookies.permanent.signed[:user_profile_id] = user_profile.id
        cookies.permanent[:remember_token] = user_profile.remember_token
    end

    # Delete the permanent session
    def forget(user_profile)
        puts "inside SessionHelper > forget(user_profile)"

        user_profile.forget
        cookies.delete(:auser_profile_id)
        cookies.delete(:remember_token)
    end

    def log_out
        puts "inside SessionHelper > log_out"

        forget(current_user_profile)
        session.delete(:user_profile_id)
        @current_user_profile = nil
    end

    def current_user_profile?(user_profile)
        puts "inside SessionsHelper > current_user_profile?(user_profile)"
        user_profile == current_user_profile
    end
end