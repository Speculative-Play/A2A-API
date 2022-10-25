class ApplicationController < ActionController::API
    include SessionsHelper
    include ActionController::Cookies

    def current_account
        puts "inside ApplicationController > current_account"
        @current_account = Account.find_by(id: session[:account_id])
    end

    def current_user_profile
        # current_account
        @current_user_profile = UserProfile.find_by(id: @current_account.user_profile)
    end

    private

    def log_in(account)
        session[:account_id] = account.id
    end



    def logged_in?
        current_account.present?
    end

    def log_out
        reset_session
        @curent_account = nil
    end

end
