class AddVehicleToDeliveryData < ActiveRecord::Migration[7.0]
  def change
    add_reference :delivery_data, :vehicle, null: false, foreign_key: true
  end
end
