# typed: false
class DiscountProductType < ApplicationRecord
  belongs_to :product
  belongs_to :discount_product_type_group

  def ==(other)
    other.class == self.class &&
      other.product_type == product_type
  end
end
