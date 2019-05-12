require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get favorites" do
    get users_favorites_url
    assert_response :success
  end

  test "should get histroy" do
    get users_histroy_url
    assert_response :success
  end

  test "should get leave" do
    get users_leave_url
    assert_response :success
  end
end
