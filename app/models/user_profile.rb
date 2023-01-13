class UserProfile < ApplicationRecord    
    has_one                 :account,                                           dependent: :destroy
    has_many                :parent_profiles,                                   dependent: :destroy
    has_many                :favourited_match_profiles,                         dependent: :destroy
    has_many                :user_question_answers,                             dependent: :destroy
    has_many                :category_percentages,                              dependent: :destroy
    has_one_attached        :avatar,                                            dependent: :destroy 
    serialize               :languages,                                         Array  
    serialize               :sisters,                                           Array   
    serialize               :brothers,                                          Array   
    serialize               :about_me,                                          Array  
    
    # class << self
    #     # Return the hash value of the given string
    #     def digest(string)
    #         puts "inside user_profile model digest(string)"
    #         puts "string = ", string
    #         cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    #         BCrypt::Password.create(string, cost: cost)
    #     end

    #     # Return a random token
    #     def generate_token
    #         puts "inside user_profile model generate_token"

    #         SecureRandom.urlsafe_base64
    #     end
    # end

    # #Create a new token -> encrypt it -> stores the hash value in remember_digest in DB
    # def remember
    #     puts "inside user_profile model remember"

    #     self.remember_token = UserProfile.generate_token
    #     puts "self.remember_token = ", self.remember_token
    #     update_attribute(:remember_digest, UserProfile.digest(remember_token))
    # end

    # # Check if the given token value matches the one stored in DB
    # def authenticated?(remember_token)
    #     puts "inside user_profile model authenticated?(remember_token)"

    #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end

    # def forget
    #     puts "inside user_profile model forget"

    #     update_attribute(:remember_digest, nil)
    # end

end
