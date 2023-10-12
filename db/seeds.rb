# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'csv'
qa_csv_file = File.read(Rails.root.join('db', 'assets', 'A2A-question-answer-bank.csv'))
qa_table = CSV.parse(qa_csv_file)
# puts qa_table

# Create UserProfiles [Women]
for u in 1..5 do 
    UserProfile.create(
        first_name: Faker::Name.unique.female_first_name,
        last_name: Faker::Name.unique.last_name,
        gender: "Woman",
        city: Faker::Address.city,
        country: Faker::Address.country,
        birth_country: Faker::Address.country,
        date_of_birth: Faker::Date.between(from: '1987-01-01', to: '2002-01-01'),
        languages: MatchProfile::LANGUAGES.sample(2).to_json,
        marital_status: Faker::Demographic.marital_status,
        education: MatchProfile::DEGREES[u % 17],
        occupation: MatchProfile::JOBS[u % 17],
        religion: MatchProfile::RELIGIONS.sample,
        father: Faker::Name.unique.male_first_name,
        mother: Faker::Name.unique.female_first_name,
        sisters: Faker::Lorem.words.to_json,
        brothers: Faker::Lorem.words.to_json,
        about_me: Faker::Lorem.sentences.to_json
    )
end

# Create UserProfiles [Men]
for u in 1..5 do
    UserProfile.create(
        first_name: Faker::Name.unique.male_first_name,
        last_name: Faker::Name.last_name,
        gender: "Man",
        city: Faker::Address.city,
        country: Faker::Address.country,
        birth_country: Faker::Address.country,
        date_of_birth: Faker::Date.between(from: '1987-01-01', to: '2002-01-01'),
        languages: MatchProfile::LANGUAGES.sample(2),
        marital_status: Faker::Demographic.marital_status,
        education: MatchProfile::DEGREES[u % 17],
        occupation: MatchProfile::JOBS[u % 17],
        religion: MatchProfile::RELIGIONS.sample.to_json,
        father: Faker::Name.unique.male_first_name,
        mother: Faker::Name.unique.female_first_name,
        sisters: Faker::Lorem.words.to_json,
        brothers: Faker::Lorem.words.to_json,
        about_me: Faker::Lorem.sentences.to_json
    )
end

# Create MatchProfiles [Women]
for m in 1..250 do 
    MatchProfile.create(
        first_name: Faker::Name.unique.female_first_name,
        last_name: Faker::Name.last_name,
        gender: "Woman",
        city: Faker::Address.city,
        country: Faker::Address.country,
        birth_country: Faker::Address.country,
        date_of_birth: Faker::Date.between(from: '1987-01-01', to: '2002-01-01'),
        languages: MatchProfile::LANGUAGES.sample(2),
        marital_status: Faker::Demographic.marital_status,
        education: MatchProfile::DEGREES[m % 17],
        occupation: MatchProfile::JOBS[m % 17],
        religion: MatchProfile::RELIGIONS.sample.to_json,
        father: Faker::Name.unique.male_first_name,
        mother: Faker::Name.unique.female_first_name,
        sisters: Faker::Lorem.words.to_json,
        brothers: Faker::Lorem.words.to_json,
        about_me: Faker::Lorem.sentences.to_json
    )
end

# Create MatchProfiles [Men]
for m in 1..250 do 
    MatchProfile.create(
        first_name: Faker::Name.unique.male_first_name,
        last_name: Faker::Name.unique.last_name,
        gender: "Man",
        city: Faker::Address.city,
        country: Faker::Address.country,
        birth_country: Faker::Address.country,
        date_of_birth: Faker::Date.between(from: '1987-01-01', to: '2002-01-01'),
        languages: MatchProfile::LANGUAGES.sample(2),
        marital_status: Faker::Demographic.marital_status,
        education: MatchProfile::DEGREES[m % 17],
        occupation: MatchProfile::JOBS[m % 17],
        religion: MatchProfile::RELIGIONS.sample.to_json,
        father: Faker::Name.unique.male_first_name,
        mother: Faker::Name.unique.female_first_name,
        sisters: Faker::Lorem.words.to_json,
        brothers: Faker::Lorem.words.to_json,
        about_me: Faker::Lorem.sentences.to_json
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
            match_profile_id: Faker::Number.between(from: 1, to: 500)
        ) 
    end
end

# Create FavouritedMatchProfiles
# Create 5 entries per UserProfile = 50 entries
for u in 1..10 do
    5.times do
        FavouritedMatchProfile.create(
            user_profile_id: u,
            match_profile_id: Faker::Number.between(from: 1, to: 500)
        ) 
    end
end

@categories = []
qa_table.drop(1).each do |row|
    if !@categories.include?(row[2])
        @categories << row[2]
    end
end

# Create MatchmakingCategories
@categories.each do |c|
    MatchmakingCategory.create(
        category_name: c,
        category_description: Faker::Lorem.sentence
    )
end

# Create CategoryPercentages for Users
# Create 1 entry per MatchmakingCategory per UserProfile = 50 entries
for u in 1..10 do
    for a in 1..@categories.count do
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
    for a in 1..@categories.count do
        CategoryPercentage.create(
            category_percentage: 20,
            matchmaking_category_id: a,
            parent_profile_id: p
        )
    end
end

# # Create Zero-One Type Questions
# # Create 5 entries per MatchmakingCategory = 50 entries
# for n in 1..5 do
#     3.times do
#         Question.create(
#             question_text: Faker::Lorem.unique.question,
#             matchmaking_category_id: n,
#             question_type: "zero-one"
#         )
#     end
# end

# # Create Range Type Questions
# # Create 5 entries per MatchmakingCategory = 50 entries
# for n in 1..5 do
#     3.times do
#         Question.create(
#             question_text: Faker::Lorem.unique.question,
#             matchmaking_category_id: n,
#             question_type: "range"
#         )
#     end
# end

@categories = []
@number_of_questions = 0
qa_table.drop(1).each do |row|
    if !@categories.include?(row[2])
        @categories << row[2]
    end
    Question.create(
        question_text: row[0],
        matchmaking_category_id: @categories.size,
        question_type: row[1]
    )
    @number_of_questions = @number_of_questions + 1
end

# Create Answers
qa_table.drop(1).each_with_index do |row, index|
    row.each_with_index do |col, i|
        
        unless col
            break
        end
        if i > 2
            Answer.create(
                answer_text: col,
                question_id: index + 1
            )
        end
    end
end


# Create UserQuestionAnswers
for q in 1..@number_of_questions do

    possible_answers = Answer.where(question_id: q)
    answers_count = possible_answers.count
    if answers_count < 1
        break
    end

    for u in 1..10 do
        answer_id = rand(possible_answers.first.id..(possible_answers.first.id + answers_count - 1))
        UserQuestionAnswer.create(
            question_id: q,
            answer_id: answer_id,
            user_profile_id: u,
            matching_algo: true
        )
    end
end

# Create MatchQuestionAnswers
for q in 1..@number_of_questions do

    possible_answers = Answer.where(question_id: q)
    answers_count = possible_answers.count
    if answers_count < 1
        break
    end

    for m in 1..500 do
        answer_id = rand(possible_answers.first.id..(possible_answers.first.id + answers_count - 1))

        MatchQuestionAnswer.create(
            question_id: q,
            answer_id: answer_id,
            match_profile_id: m
        )
    end
end