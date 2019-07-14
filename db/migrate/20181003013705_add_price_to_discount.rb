# typed: false
class AddPriceToDiscount < ActiveRecord::Migration[5.2]
  def change
    add_column :discounts, :price, :decimal, precision: 10, scale: 2
  end
end
