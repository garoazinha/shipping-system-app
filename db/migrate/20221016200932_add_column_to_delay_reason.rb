class AddColumnToDelayReason < ActiveRecord::Migration[7.0]
  def change
    add_reference :delay_reasons, :closed_delivery_datum, null: false, foreign_key: true
  end
end
