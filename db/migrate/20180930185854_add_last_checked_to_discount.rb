# typed: false
class AddLastCheckedToDiscount < ActiveRecord::Migration[5.2]
  def change
    add_column :discounts, :last_checked, :datetime
  end
end
