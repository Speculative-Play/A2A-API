require "test_helper"

class ParentAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parent_account = parent_accounts(:one)
  end

  test "should get index" do
    get parent_accounts_url, as: :json
    assert_response :success
  end

  test "should create parent_account" do
    assert_difference("ParentAccount.count") do
      post parent_accounts_url, params: { parent_account: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show parent_account" do
    get parent_account_url(@parent_account), as: :json
    assert_response :success
  end

  test "should update parent_account" do
    patch parent_account_url(@parent_account), params: { parent_account: {  } }, as: :json
    assert_response :success
  end

  test "should destroy parent_account" do
    assert_difference("ParentAccount.count", -1) do
      delete parent_account_url(@parent_account), as: :json
    end

    assert_response :no_content
  end
end
