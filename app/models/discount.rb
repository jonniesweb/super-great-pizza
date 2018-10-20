class Discount < ApplicationRecord
  has_many :discount_product_type_groups
  has_many :product_types, through: :discount_product_type_groups
  belongs_to :store
end
