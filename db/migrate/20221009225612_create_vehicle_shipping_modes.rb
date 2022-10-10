class CreateVehicleShippingModes < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicle_shipping_modes do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.references :shipping_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
