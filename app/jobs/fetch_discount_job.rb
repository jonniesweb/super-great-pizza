class FetchDiscountJob < ApplicationJob
  queue_as :default

  def perform(code)
    FetcherService.run(code)
  end
end
