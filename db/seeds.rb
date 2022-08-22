# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# 10.times do 
#     UserProfile.create(
#         first_name: Faker::Name.unique.first_name,
#         last_name: Faker::Name.unique.last_name,
#         email: Faker::Internet.email,
#         password_digest: Faker::Lorem.word
#     )
# end

# 10.times do 
#     MatchProfile.create(
#         first_name: Faker::Name.unique.first_name,
#         last_name: Faker::Name.unique.last_name,
#     )
# end

# 10.times do
#     MatchmakingCategory.create(
#         category_name: Faker::Lorem.unique.word,
#         category_description: Faker::Lorem.words(number: 5)
#     )
# end

10.times do
    for n in 1..10 do
        CategoryPercentage.create(
            category_percentage: 10,
            matchmaking_category_id: n,
            user_profile_id: n+2,
        )
    end
end