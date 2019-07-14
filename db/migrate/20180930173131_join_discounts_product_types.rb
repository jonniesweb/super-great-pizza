# typed: false
class JoinDiscountsProductTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts_product_types, id: false do |t|
      t.integer :discount_id
      t.integer :product_type_id
    end

    add_index :discounts_product_types, :discount_id
    add_index :discounts_product_types, :product_type_id
  end
end
