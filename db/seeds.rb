
sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                    min_weight: 1, max_weight: 50_000, fixed_fee: 1)
DeliveryTime.create!(min_distance: 0, max_distance: 200, estimated_delivery_time: 24,
                      shipping_mode: sm)                    
[1,2,3,4].each do |i|
  DeliveryTime.create!(min_distance: i*200+1, max_distance: i*200+200, estimated_delivery_time: 24+i*24,
                       shipping_mode: sm)
end

WeightBasedFee.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10,
                       shipping_mode: sm)
[1,2,3,4].each do |i|
  WeightBasedFee.create!(min_weight: i*10_000+1, max_weight: i*10_000+10_000, fee_per_km: 0.10*i+0.10 ,
                       shipping_mode: sm)
end

DistanceBasedFee.create!(min_distance: 0, max_distance: 200, fee: 2.00,
                         shipping_mode: sm)
[1,2,3,4].each do |i|
  DistanceBasedFee.create!(min_distance: i*200+1, max_distance: i*200+200, fee: i*2+2,
                          shipping_mode: sm)
end

other_sm = ShippingMode.create!(name: 'Convencional', min_distance: 0, max_distance: 3000,
                     min_weight: 1, max_weight: 100_000, fixed_fee: 0.5)

DeliveryTime.create!(min_distance: 0, max_distance: 300, estimated_delivery_time: 36,
                      shipping_mode: other_sm)                    
(1..9).each do |i|
  DeliveryTime.create!(min_distance: i*300+1, max_distance: i*300+300, estimated_delivery_time: 36+i*24,
                       shipping_mode: other_sm)
end

WeightBasedFee.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10,
                       shipping_mode: other_sm)
(1..9).each do |i|
  WeightBasedFee.create!(min_weight: i*10_000+1, max_weight: i*10_000+10_000, fee_per_km: 0.07*i+0.10 ,
                       shipping_mode: other_sm)
end

DistanceBasedFee.create!(min_distance: 0, max_distance: 300, fee: 2.00,
                         shipping_mode: other_sm)
(1..9).each do |i|
  DistanceBasedFee.create!(min_distance: i*300+1, max_distance: i*300+300, fee: 2.00+i*0.75,
                          shipping_mode: other_sm)
end
User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :admin)

vehicle_a = Vehicle.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                year: 2017, max_capacity: 1500, activity: :operational)
vehicle_a.vehicle_shipping_modes.create!(shipping_mode: sm)
vehicle_a.vehicle_shipping_modes.create!(shipping_mode: other_sm)
vehicle_b = Vehicle.create!(plate_number: 'ABC1234', model: 'Sprinter', brand: 'Mercedes-Benz',
                year: 2013, max_capacity: 1500, activity: :operational)
vehicle_b.vehicle_shipping_modes.create!(shipping_mode: sm)
vehicle_b.vehicle_shipping_modes.create!(shipping_mode: other_sm)
vehicle_c = Vehicle.create!(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
                            year: 2018, max_capacity: 1300, activity: :maintenance)
vehicle_c.vehicle_shipping_modes.create!(shipping_mode: other_sm)
vehicle_d = Vehicle.create!(plate_number: 'ZEF0987', model: 'Honda', brand: 'Pop',
                            year: 2015, max_capacity: 10, activity: :operational)
vehicle_d.vehicle_shipping_modes.create!(shipping_mode: other_sm)
vehicle_d.vehicle_shipping_modes.create!(shipping_mode: sm)


            
service_order = ServiceOrder.create!(product_code: 'ABC1234', product_width: 20,
  product_height: 20, product_depth: 10, product_weight: 1000,
  recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200,
full_addresses_attributes: [{belonging_to: :recipient, 
  zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12'},
  {belonging_to: :shipper,
  zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95'}])

