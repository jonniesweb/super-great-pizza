# typed: false
module Fetchers
  class StoreService
    include ApiHelper

    StoreFetchError = Class.new(StandardError)

    def initialize(store_id:, address: nil)
      @store_id = store_id
      @address = address
    end

    def fetch
      query(uri).then do |response|
        body = JSON.parse(response.body)

        Store.find_or_create_by!(code: store_id) do |store|
          store.json = body
          store.address = address if address
        end

        products = body.fetch('Variants')

        products.keys.each do |code|
          Product.find_or_create_by!(code: code) do |product_type|
            product_type.name = products.dig(code, 'Name')
          end
        end

        body.fetch('Coupons').keys.each do |code|
          FetchDiscountJob.perform_later(code, store_id)
        end
      end
    rescue Net::ReadTimeout => e
      raise StoreFetchError, "Unexpected code #{response.code} for store_id: #{store_id}, #{e}"
    end

    private

    def uri
      "https://order.dominos.ca/power/store/#{store_id}/menu?lang=en&structured=true"
    end

    attr_reader :store_id
    attr_reader :address
  end
end
