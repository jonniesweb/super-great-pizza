# typed: true
# frozen_string_literal: true

class LocationBuilder
  include ActiveModel::Model

  attr_accessor :city
  attr_accessor :postal_code
  attr_accessor :province
  attr_accessor :address
end
