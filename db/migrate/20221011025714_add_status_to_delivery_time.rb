class AddStatusToDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_times, :status, :integer, default: 2
  end
end
