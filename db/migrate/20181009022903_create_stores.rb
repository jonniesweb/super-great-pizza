# typed: true
class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :code
      t.string :city
      t.string :address
      t.json :json

      t.timestamps
    end
  end
end
