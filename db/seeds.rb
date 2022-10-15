
ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                    min_weight: 1, max_weight: 10000, fixed_fee: 1)

DeliveryTime.create!(min_distance: 0, max_distance: 100, estimated_delivery_time: 24,
                     shipping_mode: ShippingMode.first)
DeliveryTime.create!(min_distance: 101, max_distance: 200, estimated_delivery_time: 36,
                     shipping_mode: ShippingMode.first)
WeightBasedFee.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10,
                       shipping_mode: ShippingMode.first)
WeightBasedFee.create!(min_weight: 10_001, max_weight: 50_000, fee_per_km:0.25,
                     shipping_mode: ShippingMode.first)
DistanceBasedFee.create!(min_distance: 0, max_distance: 200, fee: 2.00,
                         shipping_mode: ShippingMode.first)
DistanceBasedFee.create!(min_distance: 201, max_distance: 500, fee: 5.00,
                         shipping_mode: ShippingMode.first)
ShippingMode.create!(name: 'Convencional', min_distance: 0, max_distance: 3000,
                     min_weight: 1, max_weight: 100000, fixed_fee: 0.5)
User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :admin)

Vehicle.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                year: 2017, max_capacity: 1500, activity: :operational)

Vehicle.create!(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
              year: 2018, max_capacity: 1300, activity: :maintenance)


            
service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
  product_height: 20, product_depth: 10, product_weight: 1000,
  recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200)
s_address = service_order.full_addresses.build(belonging_to: :recipient, 
    zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
r_address = service_order.full_addresses.build(belonging_to: :shipper,
    zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
service_order.save