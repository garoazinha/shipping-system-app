class CreateFullAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :full_addresses do |t|
      t.references :service_order, null: false, foreign_key: true
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :address
      t.integer :belonging_to, default: 5

      t.timestamps
    end
  end
end
