class CreateDeliveryData < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_data do |t|
      t.references :shipping_mode, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true
      t.decimal :total_price, precision: 6, scale: 2
      t.integer :estimated_delivery_time

      t.timestamps
    end
  end
end
