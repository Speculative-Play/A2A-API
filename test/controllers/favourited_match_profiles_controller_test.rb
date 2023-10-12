require "test_helper"

class FavouritedMatchProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @favourited_match_profile = favourited_match_profiles(:one)
  end

  test "should get index" do
    get favourited_match_profiles_url, as: :json
    assert_response :success
  end

  test "should create favourited_match_profile" do
    assert_difference("FavouritedMatchProfile.count") do
      post favourited_match_profiles_url, params: { favourited_match_profile: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show favourited_match_profile" do
    get favourited_match_profile_url(@favourited_match_profile), as: :json
    assert_response :success
  end

  test "should update favourited_match_profile" do
    patch favourited_match_profile_url(@favourited_match_profile), params: { favourited_match_profile: {  } }, as: :json
    assert_response :success
  end

  test "should destroy favourited_match_profile" do
    assert_difference("FavouritedMatchProfile.count", -1) do
      delete favourited_match_profile_url(@favourited_match_profile), as: :json
    end

    assert_response :no_content
  end
end
