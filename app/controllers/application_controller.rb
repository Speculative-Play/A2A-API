class ApplicationController < ActionController::API
    include ActionController::Helpers

    def current_user_profile
        @current_user_profile ||= UserProfile.find(session[:user_profile_id]) if session[:user_profile_id] 
        # @current_user_profile ||= UserProfile.find(1)
    end

    def logged_in?
        !!current_user_profile
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

    def not_found
        render json: { error: 'not_found' }
    end
    
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user_profile = UserProfile.find(@decoded[:user_profile_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end

    # sorts the match-profiles by x attribute - could be used for search or for piechart matching
    def sort_match_profiles_by_attribute(a:)
        match_profiles.sort_by {|prof| prof.a}
        Rails.logger.info 'inside sort_match_by_attributes ApplicationController'
    end
end
