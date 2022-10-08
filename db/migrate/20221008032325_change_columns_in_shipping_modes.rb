class ChangeColumnsInShippingModes < ActiveRecord::Migration[7.0]
  def change
    change_column :shipping_modes, :fixed_fee, :decimal, precision: 4, scale: 2
  end
end
