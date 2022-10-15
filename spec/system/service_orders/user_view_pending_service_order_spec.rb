require 'rails_helper'

describe 'Usuário visualiza lista de ordens de serviço pendentes' do
  it 'a partir da página de ordens de serviço' do
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :standard)
    service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
      product_height: 20, product_depth: 10, product_weight: 1000,
      recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200)
    s_address = service_order.full_addresses.build(belonging_to: :recipient, 
        zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
    r_address = service_order.full_addresses.build(belonging_to: :shipper,
        zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
    other_service_order = ServiceOrder.new(product_code: 'DEF09876', product_width: 30,
      product_height: 40, product_depth: 50, product_weight: 450,
      recipient_name: 'Jose Santos', recipient_registration_number: '91200011198', distance: 300, status: :closed)
    other_s_address = other_service_order.full_addresses.build(belonging_to: :recipient, 
        zip_code: '555550000', city: 'Rio de Janeiro', state: 'RJ', address: 'Avenida Rosa, 201')
    other_r_address = other_service_order.full_addresses.build(belonging_to: :shipper,
        zip_code: '444440000', city: 'Maringá', state: 'PR', address: 'Avenida Vermelho, 101')
    service_order.save
    other_service_order.save

    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'

    expect(page).to have_content("Saída")
    expect(page).to have_content("Destino")
    expect(page).to have_content("Código da ordem de serviço")
    expect(page).to have_link("#{service_order.code}")
    expect(page).not_to have_link("#{other_service_order.code}")
    expect(page).to have_content("São Paulo - SP")
    expect(page).to have_content("Curitiba - PR")
    expect(page).not_to have_content("Rio de Janeiro - RJ")
    expect(page).not_to have_content("Maringá - PR")
    expect(service_order.pending?).to be true
    expect(other_service_order.closed?).to be true
  end

  it 'e visualiza modalidades de transporte disponíveis' do
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :standard)
    sm = ShippingMode.create!(name: "Pequenas Distâncias", min_distance: 0, max_distance: 100, 
                              min_weight: 0, max_weight: 15_000, fixed_fee: 2.00)
    other_sm = ShippingMode.create!(name: "Convencional", min_distance: 0, max_distance: 1000, 
                                min_weight: 0, max_weight: 100_000, fixed_fee: 5.00)
                                
    service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
      product_height: 20, product_depth: 10, product_weight: 854,
      recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200)
    s_address = service_order.full_addresses.build(belonging_to: :recipient, 
        zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
    r_address = service_order.full_addresses.build(belonging_to: :shipper,
        zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
    service_order.save


    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on "#{service_order.code}"

    expect(page).to have_content("Avenida Amarelo, 12")
    expect(page).to have_content("Avenida Roxo, 95")
    expect(page).to have_content("01234567899")
    expect(page).to have_content("Maria Silva")
    expect(page).to have_content("Convencional")
    expect(page).not_to have_content("Pequenas Distâncias")
  end

  it 'e visualiza prazo e preço total' do
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :standard)
    sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 1000_000, fixed_fee: 5.00)
    sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 24)
    sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 48)
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
    sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 50_000, fee_per_km:0.25)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 2.00)
    sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 5.00)
    service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
      product_height: 20, product_depth: 10, product_weight: 1000,
      recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200)
    s_address = service_order.full_addresses.build(belonging_to: :recipient, 
        zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
    r_address = service_order.full_addresses.build(belonging_to: :shipper,
        zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
    service_order.save


    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on "#{service_order.code}"

    expect(page).to have_content("Avenida Amarelo, 12")
    expect(page).to have_content("Avenida Roxo, 95")
    expect(page).to have_content("01234567899")
    expect(page).to have_content("Maria Silva")
    expect(page).to have_content("Express")
    expect(page).to have_content("Taxa fixa: R$5,00")
    expect(page).to have_content("Prazo estimado: 48 horas")
    expect(page).to have_content("Preço total: R$27,00")

  end
end