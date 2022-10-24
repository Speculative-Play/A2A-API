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

ActiveRecord::Schema[7.0].define(version: 2022_10_24_195834) do
  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_profile_id"
    t.integer "parent_profile_id"
    t.integer "account_type"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["parent_profile_id"], name: "index_accounts_on_parent_profile_id"
    t.index ["user_profile_id"], name: "index_accounts_on_user_profile_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.string "answer_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "category_percentages", force: :cascade do |t|
    t.integer "category_percentage"
    t.integer "matchmaking_category_id"
    t.integer "user_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matchmaking_category_id"], name: "index_category_percentages_on_matchmaking_category_id"
    t.index ["user_profile_id"], name: "index_category_percentages_on_user_profile_id"
  end

  create_table "favourited_match_profiles", force: :cascade do |t|
    t.integer "user_profile_id"
    t.integer "match_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_profile_id"], name: "index_favourited_match_profiles_on_match_profile_id"
    t.index ["user_profile_id"], name: "index_favourited_match_profiles_on_user_profile_id"
  end

  create_table "match_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
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

  create_table "matchmaking_categories", force: :cascade do |t|
    t.string "category_name"
    t.string "category_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parent_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_profile_id"
    t.index ["user_profile_id"], name: "index_parent_profiles_on_user_profile_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "matchmaking_category_id"
    t.index ["matchmaking_category_id"], name: "index_questions_on_matchmaking_category_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "session_type"
    t.integer "account_id"
  end

  create_table "starred_match_profiles", force: :cascade do |t|
    t.integer "parent_profile_id"
    t.integer "match_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_profile_id"], name: "index_starred_match_profiles_on_match_profile_id"
    t.index ["parent_profile_id"], name: "index_starred_match_profiles_on_parent_profile_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "first_name", null: false
    t.string "last_name", null: false
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

  add_foreign_key "accounts", "parent_profiles"
  add_foreign_key "accounts", "user_profiles"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "category_percentages", "matchmaking_categories"
  add_foreign_key "category_percentages", "user_profiles"
  add_foreign_key "favourited_match_profiles", "match_profiles"
  add_foreign_key "favourited_match_profiles", "user_profiles"
  add_foreign_key "match_question_answers", "answers"
  add_foreign_key "match_question_answers", "match_profiles"
  add_foreign_key "match_question_answers", "questions"
  add_foreign_key "parent_profiles", "user_profiles"
  add_foreign_key "questions", "matchmaking_categories"
  add_foreign_key "starred_match_profiles", "match_profiles"
  add_foreign_key "starred_match_profiles", "parent_profiles"
  add_foreign_key "user_question_answers", "answers"
  add_foreign_key "user_question_answers", "questions"
  add_foreign_key "user_question_answers", "user_profiles"
end
