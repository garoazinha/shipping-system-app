class CreateClosedDeliveryData < ActiveRecord::Migration[7.0]
  def change
    create_table :closed_delivery_data do |t|
      t.integer :status, default: 3
      t.references :service_order, null: false, foreign_key: true
      t.datetime :closing_date
      t.string :delay_reason

      t.timestamps
    end
  end
end
