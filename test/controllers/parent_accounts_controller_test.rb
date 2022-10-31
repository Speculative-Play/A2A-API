require "test_helper"

class ParentProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parent_profile = parent_profiles(:one)
  end

  test "should get index" do
    get parent_profiles_url, as: :json
    assert_response :success
  end

  test "should create parent_profile" do
    assert_difference("ParentProfile.count") do
      post parent_profiles_url, params: { parent_profile: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show parent_profile" do
    get parent_profile_url(@parent_profile), as: :json
    assert_response :success
  end

  test "should update parent_profile" do
    patch parent_profile_url(@parent_profile), params: { parent_profile: {  } }, as: :json
    assert_response :success
  end

  test "should destroy parent_profile" do
    assert_difference("ParentProfile.count", -1) do
      delete parent_profile_url(@parent_profile), as: :json
    end

    assert_response :no_content
  end
end
