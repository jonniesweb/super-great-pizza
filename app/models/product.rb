# typed: false
class Product < ApplicationRecord
  has_many :discount_product_types
  has_many :discount_product_type_groups, through: :discount_product_types
end
