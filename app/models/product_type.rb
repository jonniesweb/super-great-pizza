class ProductType < ApplicationRecord
  has_many :discount_product_types
  has_many :discounts, through: :discount_product_types
end
