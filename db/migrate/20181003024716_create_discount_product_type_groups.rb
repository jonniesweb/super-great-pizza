class CreateDiscountProductTypeGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_product_type_groups do |t|
      t.integer :discount_id
      t.integer :required_quantity
      t.integer :max_quantity

      t.timestamps
    end
  end
end
