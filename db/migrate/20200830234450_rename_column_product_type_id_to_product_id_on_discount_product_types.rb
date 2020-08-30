class RenameColumnProductTypeIdToProductIdOnDiscountProductTypes < ActiveRecord::Migration[6.0]
  def change
    rename_column :discount_product_types, :product_type_id, :product_id
  end
end
