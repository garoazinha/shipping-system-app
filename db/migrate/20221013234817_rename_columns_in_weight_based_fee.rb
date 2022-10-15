class RenameColumnsInWeightBasedFee < ActiveRecord::Migration[7.0]
  def change
    rename_column :weight_based_fees, :min_distance, :min_weight
    rename_column :weight_based_fees, :max_distance, :max_weight

  end
end
