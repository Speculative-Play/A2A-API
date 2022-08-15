require "test_helper"

class CategoryPercentagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_percentage = category_percentages(:one)
  end

  test "should get index" do
    get category_percentages_url, as: :json
    assert_response :success
  end

  test "should create category_percentage" do
    assert_difference("CategoryPercentage.count") do
      post category_percentages_url, params: { category_percentage: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show category_percentage" do
    get category_percentage_url(@category_percentage), as: :json
    assert_response :success
  end

  test "should update category_percentage" do
    patch category_percentage_url(@category_percentage), params: { category_percentage: {  } }, as: :json
    assert_response :success
  end

  test "should destroy category_percentage" do
    assert_difference("CategoryPercentage.count", -1) do
      delete category_percentage_url(@category_percentage), as: :json
    end

    assert_response :no_content
  end
end
