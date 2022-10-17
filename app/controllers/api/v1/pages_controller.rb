class Api::V1::PagesController < ApplicationController
    def home
        redirect_to user_profile_path if logged_in?
    end

    def about
        puts "inside pages_controller > about"
    end
end
