class RemoveLocationFromDiscount < ActiveRecord::Migration[5.2]
  def change
    remove_column :discounts, :location
  end
end
