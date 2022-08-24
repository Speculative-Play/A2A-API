require "test_helper"

class StarredMatchProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @starred_match_profile = starred_match_profiles(:one)
  end

  test "should get index" do
    get starred_match_profiles_url, as: :json
    assert_response :success
  end

  test "should create starred_match_profile" do
    assert_difference("StarredMatchProfile.count") do
      post starred_match_profiles_url, params: { starred_match_profile: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show starred_match_profile" do
    get starred_match_profile_url(@starred_match_profile), as: :json
    assert_response :success
  end

  test "should update starred_match_profile" do
    patch starred_match_profile_url(@starred_match_profile), params: { starred_match_profile: {  } }, as: :json
    assert_response :success
  end

  test "should destroy starred_match_profile" do
    assert_difference("StarredMatchProfile.count", -1) do
      delete starred_match_profile_url(@starred_match_profile), as: :json
    end

    assert_response :no_content
  end
end
