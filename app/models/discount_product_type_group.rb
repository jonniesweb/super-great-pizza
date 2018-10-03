class DiscountProductTypeGroup < ApplicationRecord
  belongs_to :discount
  has_many :discount_product_types
  has_many :product_types, through: :discount_product_types
end
