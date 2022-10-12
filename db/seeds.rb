
ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                    min_weight: 1, max_weight: 10000, fixed_fee: 1)

DeliveryTime.create!(min_distance: 0, max_distance: 100, estimated_delivery_time: 24,
                     shipping_mode: ShippingMode.first)
DeliveryTime.create!(min_distance: 101, max_distance: 200, estimated_delivery_time: 36,
                     shipping_mode: ShippingMode.first)
ShippingMode.create!(name: 'Convencional', min_distance: 0, max_distance: 3000,
                     min_weight: 1, max_weight: 100000, fixed_fee: 0.5)
User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :admin)

Vehicle.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                year: 2017, max_capacity: 1500, activity: :operational)

Vehicle.create!(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
              year: 2018, max_capacity: 1300, activity: :maintenance)


