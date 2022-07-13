require "test_helper"

class MatchAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_answer = match_answers(:one)
  end

  test "should get index" do
    get match_answers_url, as: :json
    assert_response :success
  end

  test "should create match_answer" do
    assert_difference("MatchAnswer.count") do
      post match_answers_url, params: { match_answer: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show match_answer" do
    get match_answer_url(@match_answer), as: :json
    assert_response :success
  end

  test "should update match_answer" do
    patch match_answer_url(@match_answer), params: { match_answer: {  } }, as: :json
    assert_response :success
  end

  test "should destroy match_answer" do
    assert_difference("MatchAnswer.count", -1) do
      delete match_answer_url(@match_answer), as: :json
    end

    assert_response :no_content
  end
end
