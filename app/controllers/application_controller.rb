class ApplicationController < ActionController::API
    include ActionController::Helpers
    include ActionController::Cookies

    helper_method :current_user_profile
    helper_method :forget

    # def forget(user_profile)
    #     user_profile = @current_user_profile
    #     user_profile.forget
    #     cookies.delete(:user_profile_id)
    #     cookies.delete(:remember_token)
    # end

    # def forget(parent_profile)
    #     parent_profile = @current_parent_profile
    #     parent_profile.forget
    #     cookies.delete(:parent_profile_id)
    #     cookies.delete(:remember_token)
    # end

    def forget(account)
        puts "inside application_controller > forget(account)"
        # @account = @current_account
        puts "forget acount = ", @account
        if @account.account_type == 1
            puts "forget > user account found"
            @user_profile = UserProfile.where("id = ?", @account.user_profile_id).take
            puts " user_profile = ", @user_profile
            @user_profile.forget
        elsif @account.account_type == 2
            puts "forget > parent account found"
            @parent_profile = ParentProfile.where("id = ?", @account.parent_profile_id).take
            @parent_profile.forget
        else
            puts "forget > no account type found"
        end
        # account.forget
        cookies.delete(:account_id)
        cookies.delete(:remember_token)
    end

    # def log_in(parent_profile)
    #     session[:parent_profile_id] = parent_profile.id
    # end

    # def log_in(user_profile)
    #     session[:user_profile_id] = user_profile.id
    # end

    def log_in(account)
        session[:account_id] = account.id
    end

    def log_out_user_profile
        puts "inside application_controller > log_out (user_profile)"
        # forget(current_user_profile)
        @current_account = Account.where("id = ?", session[:account_id]).take
        # puts "current_account = ", @current_account
        @user_profile = UserProfile.where("id = ?", @current_account.user_profile_id).take

        forget(current_account)
        @accounts_to_remove = Account.where("user_profile_id = ?", @user_profile.id)
        puts "accounts to remove = ", @accounts_to_remove
        @accounts_to_remove.destroy_all
        Session.where("account_id = ?", @current_account.id).destroy_all
        @sessions_to_remove = Session.where("account_id = ?", @current_account.id)
        @sessions_to_remove.destroy_all
        # Account.where("account_type = ? AND user_profile_id = ?", 1, @user_profile.id).destroy_all
        @user_profile.remember_digest = nil
        @user_profile.save
        @current_user_profile = nil
        reset_session
        puts "leaving application_controller > log_out (user_profile)"
    end

    def log_out_parent_profile
        puts "inside application_controller > log_out (parent_profile)"
        @current_account = Account.where("id = ?", session[:account_id]).take
        @parent_profile = ParentProfile.where("id = ?", @current_account.parent_profile_id).take
        forget(current_account)
        @accounts_to_remove = Account.where("parent_profile_id = ?", @parent_profile.id)
        puts "accounts to remove = ", @accounts_to_remove
        @accounts_to_remove.destroy_all
        @sessions_to_remove = Session.where("account_id = ?", @current_account.id)
        @sessions_to_remove.destroy_all
        # TODO WHAT IS UP WITH THIS MISUSE OF ROW VALUE ERROR?!
        Session.where("account_id = ?", @accounts_to_remove.ids).destroy_all
        Account.where("account_type = ? AND parent_profile_id = ?", 2, @parent_profile.id).destroy_all
        @current_parent_profile = nil
        reset_session
        puts "leaving application_controller > log_out (parent_profile)"
    end

    def logged_in_parent_profile?
        puts "inside application_controller > logged_in_parent_profile?"
        !current_parent_profile.nil?
    end

    def logged_in_user_profile?
        puts "inside application_controller > logged_in_user_profile?"
        current_user_profile.nil?
        # puts "back to logged_in_user_profile as id =", @current_user_profile.id
        # puts "leaving application_controller > logged_in_user_profile?"
    end

    def remember(parent_profile)
        puts "inside ApplicationController > remember(user_profile)"
        parent_profile.remember
        cookies.permanent.signed[:parent_profile_id] = parent_profile.id
        cookies.permanent[:remember_token] = parent_profile.remember_token
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

    def current_parent_profile
        puts "inside ApplicationController > current_parent_profile"
        if (parent_profile_id = session[:parent_profile_id])
            @current_parent_profile ||= ParentProfile.find_by(id: parent_profile_id)
            puts "inside ApplicationController > current_parent_profile > if taken"
        elsif (parent_profile_id = cookies.signed(:parent_profile_id))
            puts "inside ApplicationController > current_parent_profile elsif taken"

            parent_profile = ParentProfile.find_by(id: parent_profile_id)
            if parent_profile && parent_profile.authenticated?(cookies[:remember_token])
                log_in_parent_profile parent_profile
                @current_parent_profile = parent_profile
            end
        end
        puts "leaving application_controller > current_parent_profile"
    end

    def current_user_profile
        puts "inside ApplicationController > current_user_profile"
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

    def current_account
        puts "inside application_controller > current_account"
        if (account_id = session[:account_id])
            @account = Account.where("id = ?", account_id).take
            if @account.account_type == 1
                puts "inside application_controller > current_account > account_type = user"
            elsif @account.account_type == 2
                puts "inside application_controller > current_account > account_type = parent"
            else
                puts "inside application_controller > current_account > account_type = NONE"
            end
        end
    end



end
