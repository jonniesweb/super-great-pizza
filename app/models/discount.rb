# typed: false
class Discount < ApplicationRecord
  has_many :discount_product_type_groups, dependent: :delete
  has_many :product_types, through: :discount_product_type_groups
  belongs_to :store

  default_scope { where(removed: false) }
end
