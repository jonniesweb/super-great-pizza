# frozen_string_literal: true

require_relative '../../lib/labelling_form_builder'

class LocationsController < ApplicationController
  def index
    @location = LocationBuilder.new
  end

  def search
    locations = Fetchers::LocationService.new(
      **location_params.to_h.symbolize_keys
    ).fetch

    locations.select(&:can_deliver?).each do |location|
      Fetchers::StoreService.new(
        store_id: location.store_id,
        address: location.address
      ).fetch

      redirect_to root_path(q: {
        store_id_eq: Store.find_by(code: location.store_id)
      })
    end
  end

  def location_params
    params
      .fetch('location_builder')
      .permit(:city, :postal_code, :province, :address)
  end
end
