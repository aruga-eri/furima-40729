class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :post_code
      t.integer :prefecture_id
      t.string :municipality
      t.string :house_number
      t.string :building
      t.string :phone
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
