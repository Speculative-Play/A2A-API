class ApplicationController < ActionController::API
    include ActionController::Helpers

    # def authorize
    #     redirect_to login_url, alert: "Not authorized" if current_user_profile.nil?
    # end

    # def create_profile_path
    #     redirect_to new_user_profile_path
    # end

    def forget_current_user_profile(user_profile)
        puts "inside ApplicationController > forget(user_profile)"
        user_profile.forget_current_user_profile
        cookies.delete(:user_profile_id)
        cookies.delete(:remember_token)
    end

    def forget_current_parent_account(parent_account)
        puts "inside ApplicationController > forget(user_profile)"
        parent_account.forget
        cookies.delete(:parent_account_id)
        cookies.delete(:remember_token)
    end

    def log_in_parent_account(parent_account)
        puts "inside ApplicationController > log_in_user_profile"
        session[:parent_account_id] = parent_account.id
        puts "session[:user_profile_id] = ", session[:user_profile_id]
    end

    def log_in_user_profile(user_profile)
        puts "inside ApplicationController > log_in_user_profile"
        session[:user_profile_id] = user_profile.id
        puts "session[:user_profile_id] = ", session[:user_profile_id]
    end

    def log_out_user_profile
        forget_current_user_profile(current_user_profile)
        session.delete(:user_profile_id)
        # @current_user_profile.remember_digest = nil
        @current_user_profile = nil
    end

    def log_out_parent_account
        forget_current_parent_account(current_parent_account)
        session.delete(:parent_account_id)
        @current_parent_account = nil
    end

    def logged_in_parent_account?
        !current_parent_account.nil?
    end

    def logged_in_user_profile?
        puts "inside application_controller > logged_in_user_profile?"
        !current_user_profile.nil?
        # puts "back to logged_in_user_profile as id =", @current_user_profile.id
        puts "leaving application_controller > logged_in_user_profile?"
    end

    def remember(parent_account)
        puts "inside ApplicationController > remember(user_profile)"
        parent_account.remember
        cookies.permanent.signed[:parent_account_id] = parent_account.id
        cookies.permanent[:remember_token] = parent_account.remember_token
    end

    def remember(user_profile)
        puts "inside ApplicationController > remember(user_profile)"
        user_profile.remember
        cookies.permanent.signed[:user_profile_id] = user_profile.id
        cookies.permanent[:remember_token] = user_profile.remember_token
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

    # private

    def current_parent_account
        puts "inside ApplicationController > current_user_profile"
        if (parent_account_id = session[:parent_account_id])
            @current_parent_account ||= ParentAccount.find_by(id: parent_account_id)
        elsif (parent_account_id = cookies.signed(:parent_account_id))
            # puts "inside ApplicationController > current_user_profile elsif taken"

            parent_account = ParentAccount.find_by(id: parent_account_id)
            if parent_account && parent_account.authenticated?(cookies[:remember_token])
                log_in_parent_account parent_account
                @current_parent_account = parent_account
            end
        end
    end

    def current_user_profile
        puts "inside ApplicationController > current_user_profile"
        # puts "user_profile_id =", user_profile_id
        if (user_profile_id = session[:user_profile_id])
            @current_user_profile ||= UserProfile.find_by(id: user_profile_id)
            puts "inside ApplicationController > current_user_profile > if taken > user_profile_id == session[user_profile_id"
            # puts "current_user_profile id = ", @current_user_profile.id
        elsif (user_profile_id = cookies.signed(:user_profile_id))
            puts "inside ApplicationController > current_user_profile elsif taken"

            user_profile = UserProfile.find_by(id: user_profile_id)
            if user_profile && user_profile.authenticated?(cookies[:remember_token])
                log_in_user_profile user_profile
                @current_user_profile = user_profile
            end
        end
        puts "leaving ApplicationController > current_user_profile"
    end

    # helper_method :current_user_profile
end
