class AddDeliveryDatumToClosedDeliveryDatum < ActiveRecord::Migration[7.0]
  def change
    add_reference :closed_delivery_data, :delivery_datum, null: false, foreign_key: true
  end
end
