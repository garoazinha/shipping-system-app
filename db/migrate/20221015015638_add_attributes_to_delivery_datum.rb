class AddAttributesToDeliveryDatum < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_data, :creation_date, :datetime
    add_column :delivery_data, :end_date, :datetime
  end
end
