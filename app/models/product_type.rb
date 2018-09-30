class ProductType < ApplicationRecord
  has_and_belongs_to_many :discounts
end
