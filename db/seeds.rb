# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# Create UserProfiles
10.times do 
    UserProfile.create(
        first_name: Faker::Name.unique.first_name,
        last_name: Faker::Name.unique.last_name,
        email: Faker::Internet.email,
        password_digest: Faker::Internet.password
    )
end

# Create MatchProfiles
10.times do 
    MatchProfile.create(
        first_name: Faker::Name.unique.first_name,
        last_name: Faker::Name.unique.last_name
    )
end

# Create MatchmakingCategories
5.times do
    MatchmakingCategory.create(
        category_name: Faker::Lorem.unique.word,
        category_description: Faker::Lorem.sentence
    )
end

# Create CategoryPercentages
# Create 1 entry per MatchmakingCategory per UserProfile = 50 entries
for n in 1..10 do
    for a in 1..5 do
        CategoryPercentage.create(
            category_percentage: 20,
            matchmaking_category_id: a,
            user_profile_id: n
        )
    end
end

# Create Questions
# Create 5 entries per MatchmakingCategory = 50 entries
for n in 1..5 do
    5.times do
        Question.create(
            question_text: Faker::Lorem.unique.question,
            matchmaking_category_id: n
        )
    end
end

# Create Answers
# Create 5 entries per Question = 250 entries
for q in 1..50 do
    5.times do
        Answer.create(
            answer_text: Faker::Lorem.sentence,
            question_id: q
        )
    end
end

# Create UserQuestionAnswers
# Create 1 entry per Question per UserProfile = 50 * 10 = 500 entries
for q in 1..50 do
    for u in 1..10 do
        UserQuestionAnswer.create(
            question_id: q,
            answer_id: q*5-Faker::Number.between(from: 0, to: 4),
            user_profile_id: u
        )
    end
end

# Create MatchQuestionAnswers
# Create 1 entry per Question per MatchProfile = 50 * 10 = 500 entries
for q in 1..50 do
    for m in 1..10 do
        MatchQuestionAnswer.create(
            question_id: q,
            answer_id: q*5-Faker::Number.between(from: 0, to: 4),
            match_profile_id: m
        )
    end
end

# Create ParentAccounts
for u in 1..10 do
    ParentAccount.create(
        user_profile_id: u,
        password_digest: Faker::Internet.password,
        email: Faker::Internet.email
    )
end

# Create StarredMatchProfiles
# Create 5 entries per ParentAccount = 50 entries
for p in 1..10 do
    5.times do
        StarredMatchProfile.create(
            parent_account_id: p,
            match_profile_id: Faker::Number.between(from: 1, to: 10)
        ) 
    end
end