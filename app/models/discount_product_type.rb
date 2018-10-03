class DiscountProductType < ApplicationRecord
  belongs_to :product_type
  belongs_to :discount_product_type_group
end
