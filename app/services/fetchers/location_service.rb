# frozen_string_literal: true

module Fetchers
  class LocationService
    include ApiHelper

    LocationFetchError = Class.new(StandardError)

    Store = Struct.new(:store_id, :address, :delivery, keyword_init: true) do
      def can_deliver?
        delivery
      end
    end

    def initialize(city:, postal_code:, province:, address:)
      @city = city
      @postal_code = postal_code
      @province = province
      @address = address
    end

    def fetch
      query(uri).then do |response|
        body = JSON.parse(response.body)

        body.fetch('Stores').map do |store|
          Store.new(
            store_id: store.fetch('StoreID'),
            address: store.fetch('AddressDescription'),
            delivery: store.fetch('IsDeliveryStore'),
          )
        end
      rescue Net::ReadTimeout => e
        raise LocationFetchError,
          "Error fetching location for #{uri}, status: #{response.code}, #{e}" and retry
      end
    end

    private

    def uri(type: 'locations'.capitalize)
      URI::encode("https://order.dominos.ca/power/store-locator?type=#{type}" \
        "&c=#{city}, #{province} #{postal_code}&s=#{address}")
    end

    attr_reader :city
    attr_reader :postal_code
    attr_reader :province
    attr_reader :address
  end
end
