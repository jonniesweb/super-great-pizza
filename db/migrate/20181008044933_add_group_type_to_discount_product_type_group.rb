# typed: false
class AddGroupTypeToDiscountProductTypeGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :discount_product_type_groups, :group_type, :string
  end
end
