require 'rails_helper'


describe 'Usuário fecha ordem de serviço' do
  it 'sem atraso' do
    
    user = User.create!(name: "Mariana Souza", email: "mari@sistemadefrete.com.br", password: 'password')
    service_order = ServiceOrder.new(product_code: 'DEF09872', product_width: 30, product_height: 50,
       product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro", recipient_registration_number: '01234567899',
       distance: 150)
    service_order.full_addresses.build(zip_code: '33000000', city: 'Maringá', state: 'PR',
                                         address: 'Rua do Triângulo, 21', belonging_to: :recipient)
    service_order.full_addresses.build(zip_code: '99000000', city: 'Curitiba', state: 'PR',
                                          address: 'Rua do Losango, 40', belonging_to: :shipper)
    service_order.save!
    sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                             min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
    sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 24)
    sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 48)
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
    sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 30_000, fee_per_km:0.25)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 2.00)
    sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 5.00)
    v = sm.vehicles.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2017, max_capacity: 1500, activity: :operational)
    estimated_delivery_time =  sm.find_estimated_delivery_time(distance: service_order.distance)  
    total_price = sm.total_price(distance: service_order.distance,
                               product_weight: service_order.product_weight)
    
    delivery = service_order.create_delivery_datum(shipping_mode: sm, vehicle: v,
                                        estimated_delivery_time: estimated_delivery_time,
                                        total_price: total_price, creation_date: Time.now,
                                        end_date: Time.now + estimated_delivery_time.hours )
                                        
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on "#{service_order.code}"
    click_on "Fechar"
    
    expect(page).to have_content("Ordem de serviço terminada no prazo")
    expect(page).to have_content("Status: No prazo")
    expect(page).to have_content("Data de fechamento de ordem de serviço: #{I18n.l(Date.today)}")
    

    

  end

  it 'com atraso' do
    
    user = User.create!(name: "Mariana Souza", email: "mari@sistemadefrete.com.br", password: 'password')
    service_order = ServiceOrder.new(product_code: 'DEF09872', product_width: 30, product_height: 50,
       product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro", recipient_registration_number: '01234567899',
       distance: 150)
    service_order.full_addresses.build(zip_code: '33000000', city: 'Maringá', state: 'PR',
                                         address: 'Rua do Triângulo, 21', belonging_to: :recipient)
    service_order.full_addresses.build(zip_code: '99000000', city: 'Curitiba', state: 'PR',
                                          address: 'Rua do Losango, 40', belonging_to: :shipper)
    service_order.save!
    sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                             min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
    sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 24)
    sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 48)
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
    sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 30_000, fee_per_km:0.25)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 2.00)
    sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 5.00)
    v = sm.vehicles.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2017, max_capacity: 1500, activity: :operational)
    estimated_delivery_time =  sm.find_estimated_delivery_time(distance: service_order.distance)
    
    total_price = sm.total_price(distance: service_order.distance,
                               product_weight: service_order.product_weight)
    delivery = service_order.create_delivery_datum(shipping_mode: sm, vehicle: v,
                                        estimated_delivery_time: estimated_delivery_time,
                                        total_price: total_price, creation_date: 5.days.ago,
                                        end_date: 5.days.ago + estimated_delivery_time.hours )
  

    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on "#{service_order.code}"
    click_on "Fechar"
      
    expect(current_path).to eq(new_service_order_delay_reason_path(service_order.id))
    expect(page).to have_field("Motivo do atraso")
    expect(page).to have_content("Ordem de serviço terminada com atraso")
    

  end 
  
  it 'com atraso e preenche campo de motivo de atraso' do
    
    user = User.create!(name: "Mariana Souza", email: "mari@sistemadefrete.com.br", password: 'password')
    service_order = ServiceOrder.new(product_code: 'DEF09872', product_width: 30, product_height: 50,
       product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro", recipient_registration_number: '01234567899',
       distance: 150)
    service_order.full_addresses.build(zip_code: '33000000', city: 'Maringá', state: 'PR',
                                         address: 'Rua do Triângulo, 21', belonging_to: :recipient)
    service_order.full_addresses.build(zip_code: '99000000', city: 'Curitiba', state: 'PR',
                                          address: 'Rua do Losango, 40', belonging_to: :shipper)
    service_order.save!
    sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                             min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
    sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 24)
    sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 48)
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
    sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 30_000, fee_per_km:0.25)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 2.00)
    sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 5.00)
    v = sm.vehicles.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2017, max_capacity: 1500, activity: :operational)
    estimated_delivery_time =  sm.find_estimated_delivery_time(distance: service_order.distance)
    
    total_price = sm.total_price(distance: service_order.distance,
                               product_weight: service_order.product_weight)
    delivery = service_order.create_delivery_datum(shipping_mode: sm, vehicle: v,
                                        estimated_delivery_time: estimated_delivery_time,
                                        total_price: total_price, creation_date: 5.days.ago,
                                        end_date: 5.days.ago + estimated_delivery_time.hours )
  

    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on "#{service_order.code}"
    click_on "Fechar"
    fill_in "Motivo do atraso", with: "Tempestade de areia"
    click_on "Enviar"
      
    
    expect(page).to have_content("Motivo de atraso salvo!")
    expect(page).to have_content("Tempestade de areia")
    expect(page).to have_content("Status: Atrasado")
    expect(current_path).to eq(service_order_path(service_order.id))

  end  

end