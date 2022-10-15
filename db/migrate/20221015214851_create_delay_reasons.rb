class CreateDelayReasons < ActiveRecord::Migration[7.0]
  def change
    create_table :delay_reasons do |t|
      t.string :reason_for_delay
      t.references :service_order, null: false, foreign_key: true
      t.timestamps
    end
  end
end
