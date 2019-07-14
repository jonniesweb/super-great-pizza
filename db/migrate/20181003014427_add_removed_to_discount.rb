# typed: false
class AddRemovedToDiscount < ActiveRecord::Migration[5.2]
  def change
    add_column :discounts, :removed, :boolean, default: false
  end
end
