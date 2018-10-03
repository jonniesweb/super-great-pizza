class AddGroupToDiscountProductType < ActiveRecord::Migration[5.2]
  def change
    add_column :discounts_product_types, :discount_product_type_group_id, :integer

    add_index :discounts_product_types, :discount_product_type_group_id,
      name: 'index_discount_product_types_group_id'
  end
end
