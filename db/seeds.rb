# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                    min_weight: 1, max_weight: 10000, fixed_fee: 1)
ShippingMode.create!(name: 'Convencional', min_distance: 0, max_distance: 3000,
                     min_weight: 1, max_weight: 100000, fixed_fee: 0.5)
User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :admin)

Vehicle.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                year: 2017, max_capacity: 1500, activity: :operational)

Vehicle.create!(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
              year: 2018, max_capacity: 1300, activity: :maintenance)
