require 'rails_helper'


describe 'Usuário inicializa ordem de serviço' do
  it 'selecionando modalidade de transporte' do
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :standard)
    sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
    sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 24)
    sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 48)
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
    sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 30_000, fee_per_km:0.25)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 2.00)
    sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 5.00)
    other_sm = ShippingMode.create!(name: "Convencional", min_distance: 0, max_distance: 2500, 
                              min_weight: 0, max_weight: 1000_000, fixed_fee: 3.00)
    other_sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 48)
    other_sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 72)
    other_sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.07)
    other_sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 50_000, fee_per_km:0.15)
    other_sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 1.50)
    other_sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 3.50)
    service_order = ServiceOrder.create!(product_code: 'ABC1234', product_width: 20,
      product_height: 20, product_depth: 10, product_weight: 1000,
      recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200,
      full_addresses_attributes: [
        {belonging_to: :recipient, 
          zip_code: '12345600', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12'},
        {belonging_to: :shipper,
          zip_code: '16745600', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95'}

      ]
    )
    vehicle = Vehicle.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                      year: 2017, max_capacity: 1500, activity: :operational)
    vehicle.vehicle_shipping_modes.create!(shipping_mode: other_sm)


    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on "#{service_order.code}"
    within('div.initialize') do
      select "Convencional", from: "Modalidades de transporte"
      click_on "Iniciar"
    end
    
    expect(page).to have_content("Ordem de serviço iniciada com sucesso")
    expect(page).to have_content("72 horas")
    expect(page).to have_content("R$18,50")
    expect(service_order.delivery_datum.nil?).to be false
  end


end