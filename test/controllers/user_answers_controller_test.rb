require "test_helper"

class UserAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_answer = user_answers(:one)
  end

  test "should get index" do
    get user_answers_url, as: :json
    assert_response :success
  end

  test "should create user_answer" do
    assert_difference("UserAnswer.count") do
      post user_answers_url, params: { user_answer: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show user_answer" do
    get user_answer_url(@user_answer), as: :json
    assert_response :success
  end

  test "should update user_answer" do
    patch user_answer_url(@user_answer), params: { user_answer: {  } }, as: :json
    assert_response :success
  end

  test "should destroy user_answer" do
    assert_difference("UserAnswer.count", -1) do
      delete user_answer_url(@user_answer), as: :json
    end

    assert_response :no_content
  end
end
