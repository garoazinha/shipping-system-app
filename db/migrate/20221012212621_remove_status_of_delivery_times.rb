class RemoveStatusOfDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    remove_column :delivery_times, :status, :integer
  end
end
