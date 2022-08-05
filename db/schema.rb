# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_05_172841) do
  create_table "answers", force: :cascade do |t|
    t.string "answer_text"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answerable_id"
    t.string "answerable_type", null: false
  end

  create_table "match_profiles", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.string "location"
    t.string "job"
    t.integer "salary"
    t.string "religion"
    t.string "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_question_answers", force: :cascade do |t|
    t.integer "question_id"
    t.integer "answer_id"
    t.integer "match_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_match_question_answers_on_answer_id"
    t.index ["match_profile_id"], name: "index_match_question_answers_on_match_profile_id"
    t.index ["question_id"], name: "index_match_question_answers_on_question_id"
  end

  create_table "parent_accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "child_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_text"
    t.string "question_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
  end

  create_table "user_question_answers", force: :cascade do |t|
    t.integer "question_id"
    t.integer "answer_id"
    t.integer "user_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_user_question_answers_on_answer_id"
    t.index ["question_id"], name: "index_user_question_answers_on_question_id"
    t.index ["user_profile_id"], name: "index_user_question_answers_on_user_profile_id"
  end

  add_foreign_key "match_question_answers", "answers"
  add_foreign_key "match_question_answers", "match_profiles"
  add_foreign_key "match_question_answers", "questions"
  add_foreign_key "user_question_answers", "answers"
  add_foreign_key "user_question_answers", "questions"
  add_foreign_key "user_question_answers", "user_profiles"
end
