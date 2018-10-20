module Fetchers
  class StoreService
    include ApiHelper

    def self.call(store_id)
      StoreService.new.call(store_id)
    end

    def call(store_id = 10503)
      response = query("https://order.dominos.ca/power/store/#{store_id}/menu?lang=en&structured=true")
      raise "unexpected code #{response.code} for store id #{store_id}" unless response.code == '200'

      store = Store.find_or_initialize_by(code: store_id)

      json = JSON.parse(response.body)
      store.json = json

      store.save!

      product_types = json['Variants']
      product_types.keys.each do |code|
        product_type = ProductType.find_or_initialize_by(code: code)
        product_type.name = product_types[code]['Name']
        product_type.save!
      end

      current_discounts = json['Coupons'].keys
      current_discounts.each do |code|
        FetchDiscountJob.perform_later(code, store_id)
      end
    end
  end
end
