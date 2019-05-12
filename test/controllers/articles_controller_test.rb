require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get articles_new_url
    assert_response :success
  end

  test "should get show" do
    get articles_show_url
    assert_response :success
  end

  test "should get edit" do
    get articles_edit_url
    assert_response :success
  end

  test "should get skate" do
    get articles_skate_url
    assert_response :success
  end

  test "should get hiphop" do
    get articles_hiphop_url
    assert_response :success
  end
end
