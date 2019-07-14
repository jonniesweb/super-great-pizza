# typed: false
class AddLocationToDiscount < ActiveRecord::Migration[5.2]
  def change
    add_column :discounts, :location, :integer
  end
end
