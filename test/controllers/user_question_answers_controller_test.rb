require "test_helper"

class UserQuestionAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_question_answer = user_question_answers(:one)
  end

  test "should get index" do
    get user_question_answers_url, as: :json
    assert_response :success
  end

  test "should create user_question_answer" do
    assert_difference("UserQuestionAnswer.count") do
      post user_question_answers_url, params: { user_question_answer: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show user_question_answer" do
    get user_question_answer_url(@user_question_answer), as: :json
    assert_response :success
  end

  test "should update user_question_answer" do
    patch user_question_answer_url(@user_question_answer), params: { user_question_answer: {  } }, as: :json
    assert_response :success
  end

  test "should destroy user_question_answer" do
    assert_difference("UserQuestionAnswer.count", -1) do
      delete user_question_answer_url(@user_question_answer), as: :json
    end

    assert_response :no_content
  end
end
