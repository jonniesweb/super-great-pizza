# typed: false
class DiscountProductTypeGroup < ApplicationRecord
  belongs_to :discount
  has_many :discount_product_types, dependent: :delete
  has_many :product_types, through: :discount_product_types

  def ==(other)
    other.class == self.class &&
      other.required_quantity == required_quantity &&
      other.max_quantity == max_quantity &&
      other.group_type == group_type &&
      other.discount_product_types == discount_product_types
  end
end
