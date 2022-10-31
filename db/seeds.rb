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
    )
end

# Create MatchProfiles
50.times do 
    MatchProfile.create(
        first_name: Faker::Name.unique.first_name,
        last_name: Faker::Name.unique.last_name
    )
end

# Create ParentProfiles
for u in 1..10 do
    ParentProfile.create(
        user_profile_id: u
    )
end

# Create Accounts for UserProfiles
for u in 1..10 do
    Account.create(
        user_profile_id: u,
        password: "password",
        email: Faker::Internet.email
    )
end

# Create Accounts for ParentProfiles
for u in 1..10 do
    Account.create(
        parent_profile_id: u,
        password: "password",
        email: Faker::Internet.email
    )
end

# Create StarredMatchProfiles
# Create 5 entries per ParentProfile = 50 entries
for p in 1..10 do
    5.times do
        StarredMatchProfile.create(
            parent_profile_id: p,
            match_profile_id: Faker::Number.between(from: 1, to: 50)
        ) 
    end
end

# Create FavouritedMatchProfiles
# Create 5 entries per UserProfile = 50 entries
for u in 1..10 do
    5.times do
        FavouritedMatchProfile.create(
            user_profile_id: u,
            match_profile_id: Faker::Number.between(from: 1, to: 50)
        ) 
    end
end

# Create MatchmakingCategories
5.times do
    MatchmakingCategory.create(
        category_name: Faker::Lorem.unique.word,
        category_description: Faker::Lorem.sentence
    )
end

# Create CategoryPercentages for Users
# Create 1 entry per MatchmakingCategory per UserProfile = 50 entries
for u in 1..10 do
    for a in 1..5 do
        CategoryPercentage.create(
            category_percentage: 20,
            matchmaking_category_id: a,
            user_profile_id: u
        )
    end
end

# Create CategoryPercentages for Parents
# Create 1 entry per MatchmakingCategory per ParentProfile = 50 entries
for p in 1..10 do
    for a in 1..5 do
        CategoryPercentage.create(
            category_percentage: 20,
            matchmaking_category_id: a,
            parent_profile_id: p
        )
    end
end

# Create Zero-One Type Questions
# Create 5 entries per MatchmakingCategory = 50 entries
for n in 1..5 do
    3.times do
        Question.create(
            question_text: Faker::Lorem.unique.question,
            matchmaking_category_id: n,
            question_type: "zero-one"
        )
    end
end

# Create Range Type Questions
# Create 5 entries per MatchmakingCategory = 50 entries
for n in 1..5 do
    3.times do
        Question.create(
            question_text: Faker::Lorem.unique.question,
            matchmaking_category_id: n,
            question_type: "range"
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
# Create 1 entry per Question per MatchProfile = 50 * 50 = 2500 entries
for q in 1..50 do
    for m in 1..50 do
        MatchQuestionAnswer.create(
            question_id: q,
            answer_id: q*5-Faker::Number.between(from: 0, to: 4),
            match_profile_id: m
        )
    end
end