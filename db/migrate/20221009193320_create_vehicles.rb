class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate_number
      t.string :model
      t.string :brand
      t.integer :year
      t.integer :max_capacity
      t.integer :activity, default: 5

      t.timestamps
    end
  end
end
