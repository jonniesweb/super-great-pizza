# typed: false
class Discount < ApplicationRecord
  has_many :discount_product_type_groups, dependent: :delete_all
  has_many :products, through: :discount_product_type_groups
  belongs_to :store

  default_scope { where(removed: false) }
end
