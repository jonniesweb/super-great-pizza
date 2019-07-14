# typed: true
class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :code
      t.string :name
      t.json :json

      t.timestamps
    end
  end
end
