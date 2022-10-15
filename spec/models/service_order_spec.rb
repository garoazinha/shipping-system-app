require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe 'valido?' do
    it 'Código do produto é obrigatório' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: '', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 450,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 50)
      s_address = new_service_order.full_addresses.build(belonging_to: :recipient, 
          zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
      r_address = new_service_order.full_addresses.build(belonging_to: :shipper,
          zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
      #Act
      result = new_service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Nome do destinatário é obrigatório' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 450,
        recipient_name: '', recipient_registration_number: '01234567899', distance: 50)
      s_address = new_service_order.full_addresses.build(belonging_to: :recipient, 
          zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
      r_address = new_service_order.full_addresses.build(belonging_to: :shipper,
          zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
      #Act
      result = new_service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Distância é obrigatório' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 450,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: nil)
      s_address = new_service_order.full_addresses.build(belonging_to: :recipient, 
          zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
      r_address = new_service_order.full_addresses.build(belonging_to: :shipper,
          zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
      #Act
      result = new_service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Distância é maior que 0' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 450,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: -1)
      s_address = new_service_order.full_addresses.build(belonging_to: :recipient, 
          zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
      r_address = new_service_order.full_addresses.build(belonging_to: :shipper,
          zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
      #Act
      result = new_service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Dados de endereço são obrigatórios' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 450,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 50)
      s_address = new_service_order.full_addresses.build(belonging_to: :recipient, 
          zip_code: '', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
      r_address = new_service_order.full_addresses.build(belonging_to: :shipper,
          zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
      #Act
      result = new_service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Cada ordem de serviço deve ter dois endereços' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 450,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 50)
      s_address = new_service_order.full_addresses.build(belonging_to: :recipient, 
          zip_code: '019276333', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
          
      #Act
      result = new_service_order.valid?
      #Assert
      expect(result).to be false
    end
    it 'Cada ordem de serviço deve ter um destinatário e um recipiente' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 450,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 50)
      r_address = new_service_order.full_addresses.build(belonging_to: :shipper, 
          zip_code: '019276333', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
      rr_address = new_service_order.full_addresses.build(belonging_to: :shipper, 
            zip_code: '019276000', city: 'Curitiba', state: 'PR', address: 'Avenida Anil, 42')
          
      #Act
      result = new_service_order.valid?
      #Assert
      expect(result).to be false
    end

  end
  
  describe 'gera um código aleatório' do
    it 'ao criar ordem de serviço' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: 'ABC12345', product_width: 20,
      product_height: 20, product_depth: 10, product_weight: 450,
      recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 50)
      s_address = new_service_order.full_addresses.build(belonging_to: :recipient, 
        zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')
      r_address = new_service_order.full_addresses.build(belonging_to: :shipper,
        zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95')
      #Act 
      new_service_order.save! 
      result = new_service_order.code

      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 15
    end
  end

  describe 'Ordem de serviço é inicializada' do
    it 'e ordem de serviço sai das pendências, veículo passa a estar em uso' do
      sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
      sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 24)
      sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 48)
      sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
      sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 30_000, fee_per_km:0.25)
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
      vehicle = Vehicle.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2017, max_capacity: 1500, activity: :operational)
      vehicle.vehicle_shipping_modes.create!(shipping_mode: sm)
      estimated_delivery_time = sm.find_estimated_delivery_time(distance: service_order.distance)
      total_price = sm.total_price(distance: service_order.distance, product_weight: service_order.product_weight)
      delivery_datum = DeliveryDatum.create(shipping_mode: sm,
         vehicle: vehicle, service_order: service_order,
         estimated_delivery_time: estimated_delivery_time, total_price: total_price)

      expect(service_order.status).to eq("initialized")
      expect(vehicle.activity).to eq("busy")
  
    end
  end
end
