# typed: false
require 'test_helper'

class FetcherServiceTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test '#call enqueues FetchDiscountJobs' do
    assert_enqueued_jobs 17001, only: FetchDiscountJob do
      FetcherService.new.call(stores(:one).code)
    end
  end
end

