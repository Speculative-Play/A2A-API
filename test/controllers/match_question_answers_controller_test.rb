require "test_helper"

class MatchQuestionAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_question_answer = match_question_answers(:one)
  end

  test "should get index" do
    get match_question_answers_url, as: :json
    assert_response :success
  end

  test "should create match_question_answer" do
    assert_difference("MatchQuestionAnswer.count") do
      post match_question_answers_url, params: { match_question_answer: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show match_question_answer" do
    get match_question_answer_url(@match_question_answer), as: :json
    assert_response :success
  end

  test "should update match_question_answer" do
    patch match_question_answer_url(@match_question_answer), params: { match_question_answer: {  } }, as: :json
    assert_response :success
  end

  test "should destroy match_question_answer" do
    assert_difference("MatchQuestionAnswer.count", -1) do
      delete match_question_answer_url(@match_question_answer), as: :json
    end

    assert_response :no_content
  end
end
