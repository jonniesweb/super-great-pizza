class RenameProductTypeToProduct < ActiveRecord::Migration[6.0]
  def change
    rename_table :product_types, :products
  end
end
