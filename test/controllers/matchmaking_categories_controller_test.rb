require "test_helper"

class MatchmakingCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @matchmaking_category = matchmaking_categories(:one)
  end

  test "should get index" do
    get matchmaking_categories_url, as: :json
    assert_response :success
  end

  test "should create matchmaking_category" do
    assert_difference("MatchmakingCategory.count") do
      post matchmaking_categories_url, params: { matchmaking_category: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show matchmaking_category" do
    get matchmaking_category_url(@matchmaking_category), as: :json
    assert_response :success
  end

  test "should update matchmaking_category" do
    patch matchmaking_category_url(@matchmaking_category), params: { matchmaking_category: {  } }, as: :json
    assert_response :success
  end

  test "should destroy matchmaking_category" do
    assert_difference("MatchmakingCategory.count", -1) do
      delete matchmaking_category_url(@matchmaking_category), as: :json
    end

    assert_response :no_content
  end
end
