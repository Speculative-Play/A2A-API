class ApplicationController < ActionController::API
    include ActionController::Helpers
    include ActionController::Cookies

    helper_method :current_user_profile
    helper_method :forget

    def forget(user_profile)
        user_profile = @current_user_profile
        user_profile.forget
        cookies.delete(:user_profile_id)
        cookies.delete(:remember_token)
    end

    def forget(parent_account)
        parent_account = @current_parent_account
        parent_account.forget
        cookies.delete(:parent_account_id)
        cookies.delete(:remember_token)
    end

    def log_in(parent_account)
        session[:parent_account_id] = parent_account.id
    end

    def log_in(user_profile)
        session[:user_profile_id] = user_profile.id
    end

    def log_out
        puts "inside application_controller > log_out (user_profile)"
        forget(current_user_profile)
        session.delete(:user_profile_id)
        @user_profile = UserProfile.where("id = ?", @current_user_profile.id)
        @user_profile.remember_digest = nil
        @user_profile.save
        @current_user_profile = nil
        reset_session
        puts "leaving application_controller > log_out (user_profile)"

    end

    def log_out
        puts "inside application_controller > log_out (parent_account)"

        forget(current_parent_account)
        session.delete(:parent_account_id)
        @current_parent_account = nil
        puts "leaving application_controller > log_out (parent_account)"

    end

    def logged_in_parent_account?
        puts "inside application_controller > logged_in_parent_account?"
        !current_parent_account.nil?
    end

    def logged_in_user_profile?
        puts "inside application_controller > logged_in_user_profile?"
        current_user_profile.nil?
        # puts "back to logged_in_user_profile as id =", @current_user_profile.id
        # puts "leaving application_controller > logged_in_user_profile?"
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

    # API endpoint for 'api/v1/match' that returns to user their matchmaking category_percentages and top 10 match_profiles via matching algorithm
    # def match
        
    # end

    # private

    def current_parent_account
        puts "inside ApplicationController > current_parent_account"
        if (parent_account_id = session[:parent_account_id])
            @current_parent_account ||= ParentAccount.find_by(id: parent_account_id)
            puts "inside ApplicationController > current_parent_account > if taken"
        elsif (parent_account_id = cookies.signed(:parent_account_id))
            puts "inside ApplicationController > current_parent_account elsif taken"

            parent_account = ParentAccount.find_by(id: parent_account_id)
            if parent_account && parent_account.authenticated?(cookies[:remember_token])
                log_in_parent_account parent_account
                @current_parent_account = parent_account
            end
        end
        puts "leaving application_controller > current_parent_account"
    end

    def current_user_profile
        puts "inside ApplicationController > current_user_profile"
        # @current_user_profile_test ||= UserProfile.find_by_remember_token(cookies[:remember_token])
        # puts "current user profile token test = ", @current_user_profile_test
        # puts "user_profile_id =", user_profile.id
        if (user_profile_id = session[:user_profile_id])
            @current_user_profile ||= UserProfile.find_by(id: user_profile_id)
            puts "inside ApplicationController > current_user_profile > if taken > user_profile_id == session[user_profile_id"
            puts "current_user_profile id = ", @current_user_profile.id
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


end
