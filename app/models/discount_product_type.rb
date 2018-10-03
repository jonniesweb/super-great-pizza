class DiscountProductType < ApplicationRecord
  self.table_name = 'discounts_product_types'

  belongs_to :discount
  belongs_to :product_type
end
