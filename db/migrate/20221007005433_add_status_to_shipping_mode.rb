class AddStatusToShippingMode < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_modes, :status, :integer, default: 10
  end
end
