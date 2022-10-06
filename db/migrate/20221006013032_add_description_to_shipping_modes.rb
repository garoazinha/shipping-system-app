class AddDescriptionToShippingModes < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_modes, :description, :string
  end
end
