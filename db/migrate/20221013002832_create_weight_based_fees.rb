class CreateWeightBasedFees < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_based_fees do |t|
      t.integer :min_distance
      t.integer :max_distance
      t.decimal :fee, precision: 5, scale: 2
      t.references :shipping_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
