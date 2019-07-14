# typed: false
class RenameDiscountsProductTypesToDiscountProductTypes < ActiveRecord::Migration[5.2]
  def change
    rename_table :discounts_product_types, :discount_product_types
  end
end
