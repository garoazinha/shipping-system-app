class ChangeColumnNameWeightBasedFees < ActiveRecord::Migration[7.0]
  def change
    rename_column :weight_based_fees, :fee, :fee_per_km
  end
end
