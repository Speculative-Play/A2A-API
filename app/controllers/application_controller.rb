class ApplicationController < ActionController::API
    # helper_method :current_user, :logged_in?
    include ActionController::Helpers

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    end

    def logged_in?
        !!current_user
    end

    def authorize
        redirect_to login_url, alert: "Not authorized" if current_user.nil?
    end

    def create_profile_path
        redirect_to new_profile_path
    end

    def require_user
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
end
