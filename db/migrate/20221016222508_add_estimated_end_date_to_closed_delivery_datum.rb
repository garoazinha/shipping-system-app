class AddEstimatedEndDateToClosedDeliveryDatum < ActiveRecord::Migration[7.0]
  def change
    add_column :closed_delivery_data, :estimated_end_date, :datetime
  end
end
