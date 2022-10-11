class ApplicationController < ActionController::API
    # helper_method :current_user, :logged_in?
    # helper_method :log_in, :log_out, :logged_in?, :remember, :forget, :authorize, :create_profile_path
    include ActionController::Helpers
    # helper SessionsHelper

    def current_user_profile
        # @current_user_profile ||= UserProfile.find(session[:user_profile_id]) if session[:user_profile_id] 
        if (user_profile_id = session[:user_profile_id])
            @current_user_profile ||= UserProfile.find(:user_profile_id)
        elsif (user_profile_id = cookies.signed(:user_profile_id))
            user_profile = UserProfile.find_by(id: user_profile_id)
            if user_profile && user_profile.authenticated?(cookies[:remember_token])
                log_in user_profile
                @current_user_profile = user_profile
            end
        end
    end

    def log_in(user_profile)
        puts "inside ApplicationController#log_in"
        session[:user_profile_id] = user_profile.id
    end

    def log_out
        forget(current_user_profile)
        session.delete(:user_profile_id)
        @current_user_profile = nil
    end

    def logged_in?
        !!current_user_profile
    end

    def remember(user_profile)
        user_profile.remember
        cookies.permanent.signed[:user_profile_id] = user_profile.id
        cookies.permanent[:remember_token] = user_profile.remember_token
    end

    def forget(user_profile)
        user_profile.forget
        cookies.delete(:user_profile_id)
        cookies.delete(:remember_token)
    end

    def authorize
        redirect_to login_url, alert: "Not authorized" if current_user_profile.nil?
    end

    def create_profile_path
        redirect_to new_user_profile_path
    end

    def require_user_profile
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action!"
            redirect_to login_path
        end
    end

    # sorts the match-profiles by x attribute - could be used for search or for piechart matching
    def sort_match_profiles_by_attribute(a:)
        match_profiles.sort_by {|prof| prof.a}
        Rails.logger.info 'inside sort_match_by_attributes ApplicationController'
    end

    # API endpoint for 'api/v1/match' that returns to user their matchmaking category_percentages and top 10 match_profiles via matching algorithm
    def match
        
    end
end
