class FetchDiscountJob < ApplicationJob
  queue_as :default

  def perform(code, store_id)
    FetcherService.run(code, store_id)
  end
end
