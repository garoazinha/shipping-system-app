class CreateDistanceBasedFees < ActiveRecord::Migration[7.0]
  def change
    create_table :distance_based_fees do |t|
      t.integer :min_distance
      t.integer :max_distance
      t.decimal :fee
      t.references :shipping_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
