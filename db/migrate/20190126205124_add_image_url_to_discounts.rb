class AddImageUrlToDiscounts < ActiveRecord::Migration[5.2]
  def change
    add_column :discounts, :image_url, :string
  end
end
