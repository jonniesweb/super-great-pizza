class AddStoreToDiscount < ActiveRecord::Migration[5.2]
  def change
    add_reference :discounts, :store
  end
end
