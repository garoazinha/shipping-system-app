class CreateShippingModes < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_modes do |t|
      t.string :name
      t.integer :min_distance
      t.integer :max_distance
      t.integer :min_weight
      t.integer :max_weight
      t.decimal :fixed_fee

      t.timestamps
    end
  end
end
