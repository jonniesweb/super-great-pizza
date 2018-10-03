class RemoveDiscountFromDiscountProductType < ActiveRecord::Migration[5.2]
  def change
    remove_column :discount_product_types, :discount_id
  end
end
