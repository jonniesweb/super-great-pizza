# typed: false
require 'test_helper'

class RefreshesControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    get refresh_path
    assert_response :success
  end

  test "should post discount" do
    assert_enqueued_with(job: FetchDiscountJob, args: [discounts(:one).code, stores(:one).code]) do
      post discount_refresh_path(
        store_id: stores(:one).code,
        code: discounts(:one).code
      )
    end

    assert_redirected_to refresh_path
  end

  test "should post store" do
    post store_refresh_path(
      store_id: stores(:one).code
    )
    assert_redirected_to refresh_path
  end

  test "should post all" do
    assert_enqueued_jobs(Discount.count, only: FetchDiscountJob) do
      post all_refresh_url
    end

    assert_redirected_to refresh_path
  end
end
