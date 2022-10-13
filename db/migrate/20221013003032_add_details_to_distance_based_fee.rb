class AddDetailsToDistanceBasedFee < ActiveRecord::Migration[7.0]
  def change
    change_column :distance_based_fees, :fee, :decimal,  precision: 5, scale: 2
  end
end
