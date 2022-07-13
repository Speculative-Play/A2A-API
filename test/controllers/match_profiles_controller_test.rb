require "test_helper"

class MatchProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_profile = match_profiles(:one)
  end

  test "should get index" do
    get match_profiles_url, as: :json
    assert_response :success
  end

  test "should create match_profile" do
    assert_difference("MatchProfile.count") do
      post match_profiles_url, params: { match_profile: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show match_profile" do
    get match_profile_url(@match_profile), as: :json
    assert_response :success
  end

  test "should update match_profile" do
    patch match_profile_url(@match_profile), params: { match_profile: {  } }, as: :json
    assert_response :success
  end

  test "should destroy match_profile" do
    assert_difference("MatchProfile.count", -1) do
      delete match_profile_url(@match_profile), as: :json
    end

    assert_response :no_content
  end
end
