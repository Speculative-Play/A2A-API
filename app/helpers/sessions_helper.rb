module SessionsHelper

    def current_acount?(account)
        account == current_account
    end

    def log_in(account)
        puts "inside session_helper > log_in"
        session[:account_id] = account.id
    end

    def current_account
        if (account_id = session[:account_id])
            puts "session[:account_id] = ", account_id
            @current_account ||= Account.find_by(id: account_id)
            puts "current account id = ", @current_account.id
            if !@current_account.user_profile.nil?
                @current_user_profile = @current_account.user_profile
                puts "current user = ", @current_user_profile.id
            elsif !@current_account.parent_profile.nil?
                puts "is a parent profile!!"
            end
        elsif (account_id = cookies.signed[:account_id])
            account = Account.find_by(id: account_id)
            if account && account.authenticated?(cookies[:remember_token])
                log_in account
                @current_account = account
            end
        end    
    end

    # Make the account's session permanent
    def remember(account)
        account.remember
        cookies.permanent.signed[:account_id] = account.id
        cookies.permanent[:remember_token] = account.remember_token
    end

    # Delete the permanent session
    def forget(account)
        account.forget
        cookies.delete(:account_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forget(current_account)
        session.delete(:account_id)
        @current_account = nil
    end
end