require 'rails_helper'

describe 'Usuário faz consulta de entrega' do
  it 'a partir de página inicial' do
    
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_field("Código da entrega")
    expect(page).to have_button("Procurar")
  end

  it 'e encontra uma ordem de serviço iniciada' do
    sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
    v = sm.vehicles.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                                year: 2017, max_capacity: 1500, activity: :operational)
    v.vehicle_shipping_modes.create!(shipping_mode: sm)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return("AAAAAAAAAA00000")
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
    delivery = service_order.create_delivery_datum(shipping_mode: sm, vehicle: v,
                              estimated_delivery_time: 72,
                              total_price: 24.50, creation_date: 2.days.ago,
                              end_date: 2.days.ago + 72.hours )

    visit root_path
    fill_in "Código da entrega", with: "AAAAAAAAAA00000"
    click_on "Procurar"

    expect(page).to have_content("AAAAAAAAAA00000")
    expect(page).to have_content("Data de início: #{I18n.l(delivery.creation_date)}")
    expect(page).to have_content("Previsão de entrega: #{I18n.l(delivery.end_date)}")
    expect(page).to have_content("Veículo alocado: Mercedes-Benz Sprinter 2017, BRA0Z21")
    
  end

  it 'e encontra uma ordem de serviço finalizada no prazo' do
    sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
    v = sm.vehicles.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                                year: 2017, max_capacity: 1500, activity: :operational)
    v.vehicle_shipping_modes.create!(shipping_mode: sm)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return("AAAAAAAAAA00000")
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
    delivery = service_order.create_delivery_datum(shipping_mode: sm, vehicle: v,
                              estimated_delivery_time: 72,
                              total_price: 24.50, creation_date: 2.days.ago,
                              end_date: 1.day.ago + 72.hours )
    closed_delivery = service_order.create_closed_delivery_datum(closing_date: Time.now, delivery_datum: delivery)

    visit root_path
    fill_in "Código da entrega", with: "AAAAAAAAAA00000"
    click_on "Procurar"

    expect(page).to have_content("AAAAAAAAAA00000")
    expect(page).to have_content("Data de início: #{I18n.l(delivery.creation_date)}")
    expect(page).to have_content("Previsão de entrega: #{I18n.l(delivery.end_date)}")
    expect(page).to have_content("Veículo alocado: Mercedes-Benz Sprinter 2017, BRA0Z21")
    expect(page).to have_content("Finalizado")
    expect(page).to have_content("Status: No prazo")
    expect(page).to have_content("Data de entrega: #{I18n.l(closed_delivery.closing_date)}")

    
  end

  it 'e encontra uma ordem de serviço finalizada atrasado' do
    sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
    v = sm.vehicles.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                                year: 2017, max_capacity: 1500, activity: :operational)
    v.vehicle_shipping_modes.create!(shipping_mode: sm)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return("AAAAAAAAAA00000")
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
    delivery = service_order.create_delivery_datum(shipping_mode: sm, vehicle: v,
                              estimated_delivery_time: 72,
                              total_price: 24.50, creation_date: 5.days.ago,
                              end_date: 5.day.ago + 72.hours )
    closed_delivery = service_order.create_closed_delivery_datum(closing_date: Time.now, delivery_datum: delivery)
    delay_reason = closed_delivery.create_delay_reason(service_order: service_order, reason_for_delay: "Tempestade de pedras")

    visit root_path
    fill_in "Código da entrega", with: "AAAAAAAAAA00000"
    click_on "Procurar"

    expect(page).to have_content("AAAAAAAAAA00000")
    expect(page).to have_content("Data de início: #{I18n.l(delivery.creation_date)}")
    expect(page).to have_content("Previsão de entrega: #{I18n.l(delivery.end_date)}")
    expect(page).to have_content("Veículo alocado: Mercedes-Benz Sprinter 2017, BRA0Z21")
    expect(page).to have_content("Finalizado")
    expect(page).to have_content("Status: Atrasado")
    expect(page).to have_content("Data de entrega: #{I18n.l(closed_delivery.closing_date)}")
    expect(page).to have_content("Motivo do atraso: Tempestade de pedras")

    
  end

  it 'e não encontra nenhuma entrega' do
  

    visit root_path
    fill_in "Código da entrega", with: "AAAAAAAAAA00000"
    click_on "Procurar"

    expect(page).to have_content("Nenhuma entrega encontrada")
    
    
  end
end