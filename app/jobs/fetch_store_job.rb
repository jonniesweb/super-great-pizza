# typed: false
class FetchStoreJob < ApplicationJob
  queue_as :default

  def perform(store_id)
    Fetchers::StoreService.new(store_id: store_id).fetch
  end
end
