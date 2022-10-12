class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.string :product_code
      t.integer :product_width
      t.integer :product_height
      t.integer :product_depth
      t.integer :product_weight
      t.string :recipient_name
      t.string :recipient_registration_number
      t.integer :distance
      t.integer :status, default: 4

      t.timestamps
    end
  end
end
