require 'rails_helper'


describe 'Usuário vê ordens de serviço fechadas' do
  
  it 'a partir da tela de ordens de serviço' do
    user = User.create!(name: 'Pedro', email: 'pedro@sistemadefrete.com.br',
                       password: 'password', role: :standard)
    shipping_mode = ShippingMode.create!(name: "Pequenas distâncias", min_distance: 0,
                                         max_distance: 200, min_weight: 0, max_weight: 10_000,
                                         fixed_fee: 2.50)
    vehicle = Vehicle.create!(plate_number: 'ABC1234', model: 'CG 160', brand: 'Honda',
                             year: 2015, max_capacity: 20_00)
    vehicle.vehicle_shipping_modes.create!(shipping_mode: shipping_mode)
    service_order = ServiceOrder.create!(product_code: 'PRODA1234', product_height: 50,
                                         product_width: 30, product_depth: 30, product_weight: 900,
                                         recipient_name: 'José Tarja', recipient_registration_number: '0995331829',
                                         distance: 100, full_addresses_attributes: 
                                        [ {belonging_to: :shipper, city: "Londrina", state: "PR",
                                           zip_code: '88900000', address: 'Avenida Transparente, 64'},
                                          {belonging_to: :recipient, city: "Maringá", state: "PR",
                                            zip_code: '55700000', address: 'Rua do Verde Musgo, 33'}])
    delivery = service_order.create_delivery_datum(creation_date: Time.now, end_date: Time.now + 36.hours,
                                        total_price: 10.00, estimated_delivery_time: 36,
                                        shipping_mode: shipping_mode, vehicle: vehicle)
    delivery.create_closed_delivery_datum(closing_date: Time.now, service_order: service_order,
                                         estimated_end_date: delivery.end_date)

    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ordens de serviço finalizadas'
    
    expect(page).to have_content("#{service_order.code}")
    expect(page).to have_content("Fechado")
  end
end