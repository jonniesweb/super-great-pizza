require 'test_helper'

class RefreshesControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    get refresh_path
    assert_response :success
  end

  test "should post discount" do
    post refresh_discount_url
    assert_response :success
  end

  test "should post store" do
    post refresh_store_url
    assert_response :success
  end

  test "should post all" do
    post refresh_all_url
    assert_response :success
  end
end
