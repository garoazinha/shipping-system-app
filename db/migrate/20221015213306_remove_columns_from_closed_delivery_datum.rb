class RemoveColumnsFromClosedDeliveryDatum < ActiveRecord::Migration[7.0]
  def change
    remove_column :closed_delivery_data, :delay_reason, :string
  end
end
