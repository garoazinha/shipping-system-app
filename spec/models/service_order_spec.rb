require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe 'valido?' do
    it 'Código do produto é obrigatório' do
      #Arrange
      service_order = ServiceOrder.new(product_code: '', product_width: 30, product_height: 50,
        product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro", recipient_registration_number: '01234567899',
        distance: 150,
       full_addresses_attributes: [
         {zip_code: '33000000', city: 'Maringá', state: 'PR',
           address: 'Rua do Triângulo, 21', belonging_to: :recipient},
         {zip_code: '99000000', city: 'Curitiba', state: 'PR',
           address: 'Rua do Losango, 40', belonging_to: :shipper}
       ])
      #Act
      result = service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Nome do destinatário é obrigatório' do
      #Arrange
      service_order = ServiceOrder.new(product_code: 'ABC123', product_width: 30, product_height: 50,
        product_depth: 15, product_weight: 3000, recipient_name: "",
      recipient_registration_number: '01234567899', distance: 150,
       full_addresses_attributes: [
         {zip_code: '33000000', city: 'Maringá', state: 'PR',
           address: 'Rua do Triângulo, 21', belonging_to: :recipient},
         {zip_code: '99000000', city: 'Curitiba', state: 'PR',
           address: 'Rua do Losango, 40', belonging_to: :shipper}
       ])
      #Act
      result = service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Distância é obrigatório' do
      #Arrange
      service_order = ServiceOrder.new(product_code: 'ABC123', product_width: 30, product_height: 50,
        product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro",
      recipient_registration_number: '01234567899', distance: nil,
       full_addresses_attributes: [
         {zip_code: '33000000', city: 'Maringá', state: 'PR',
           address: 'Rua do Triângulo, 21', belonging_to: :recipient},
         {zip_code: '99000000', city: 'Curitiba', state: 'PR',
           address: 'Rua do Losango, 40', belonging_to: :shipper}
       ])
      #Act
      result = service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Distância é maior que 0' do
      #Arrange
      service_order = ServiceOrder.new(product_code: 'ABC123', product_width: 30, product_height: 50,
        product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro",
      recipient_registration_number: '01234567899', distance: -1,
       full_addresses_attributes: [
         {zip_code: '33000000', city: 'Maringá', state: 'PR',
           address: 'Rua do Triângulo, 21', belonging_to: :recipient},
         {zip_code: '99000000', city: 'Curitiba', state: 'PR',
           address: 'Rua do Losango, 40', belonging_to: :shipper}
       ])
      #Act
      result = service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Dados de endereço são obrigatórios' do
      #Arrange
      service_order = ServiceOrder.new(product_code: 'ABC123', product_width: 30, product_height: 50,
        product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro",
      recipient_registration_number: '01234567899', distance:150,
       full_addresses_attributes: [
         {zip_code: '', city: 'Maringá', state: 'PR',
           address: 'Rua do Triângulo, 21', belonging_to: :recipient},
         {zip_code: '99000000', city: 'Curitiba', state: 'PR',
           address: 'Rua do Losango, 40', belonging_to: :shipper}
       ])
      #Act
      result = service_order.valid?
      #Assert
      expect(result).to be false
    end

    it 'Cada ordem de serviço deve ter dois endereços' do
      #Arrange
      service_order = ServiceOrder.new(product_code: 'ABC123', product_width: 30, product_height: 50,
        product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro",
      recipient_registration_number: '01234567899', distance: 150,
       full_addresses_attributes: [
         {zip_code: '33000000', city: 'Maringá', state: 'PR',
           address: 'Rua do Triângulo, 21', belonging_to: :recipient}
       ])
          
      #Act
      result = service_order.valid?
      #Assert
      expect(result).to be false
    end
    it 'Cada ordem de serviço deve ter um destinatário e um recipiente' do
      #Arrange
      service_order = ServiceOrder.new(product_code: 'ABC123', product_width: 30, product_height: 50,
        product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro",
      recipient_registration_number: '01234567899', distance: 150,
       full_addresses_attributes: [
          {zip_code: '33000000', city: 'Maringá', state: 'PR',
           address: 'Rua do Triângulo, 21', belonging_to: :recipient},
          {zip_code: '99000000', city: 'Curitiba', state: 'PR',
            address: 'Rua do Losango, 40', belonging_to: :recipient}
       ])
          
      #Act
      result = service_order.valid?
      #Assert
      expect(result).to be false
    end

  end
  
  describe 'gera um código aleatório' do
    it 'ao criar ordem de serviço' do
      #Arrange
      service_order = ServiceOrder.new(product_code: 'ABC123', product_width: 30, product_height: 50,
        product_depth: 15, product_weight: 3000, recipient_name: "Miguel Pinheiro",
      recipient_registration_number: '01234567899', distance: 150,
       full_addresses_attributes: [
          {zip_code: '33000000', city: 'Maringá', state: 'PR',
           address: 'Rua do Triângulo, 21', belonging_to: :recipient},
          {zip_code: '99000000', city: 'Curitiba', state: 'PR',
            address: 'Rua do Losango, 40', belonging_to: :shipper}
       ])
      #Act 
      service_order.save! 
      result = service_order.code

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
      service_order = ServiceOrder.create!(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 1000,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200,
        full_addresses_attributes: [{belonging_to: :recipient, 
          zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12'},
          {belonging_to: :shipper,
          zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95'}])

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

    it 'e gera um objeto de dados de entrega' do
      sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
      sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 24)
      sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 48)
      sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
      sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 30_000, fee_per_km:0.25)
      sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 2.00)
      sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 5.00)
      vehicle = Vehicle.create!(plate_number: 'ABC1234', model: 'Ducato', brand: 'Fiat',
                             year: 2018, max_capacity: 150_000)
      vehicle.vehicle_shipping_modes.create!(shipping_mode: sm)
      service_order = ServiceOrder.create!(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 1000,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200,
        full_addresses_attributes: [{belonging_to: :recipient, 
          zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12'},
          {belonging_to: :shipper,
          zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95'}])
      delivery= service_order.build_delivery_data(shipping_mode: sm)
      
      delivery.save! 

      expect(delivery.total_price).to eq(27)
      expect(delivery.estimated_delivery_time).to eq(48)
      expect(delivery.vehicle.plate_number).to eq('ABC1234')
      
    end

    it 'a partir das modalidades de transporte que o atendem' do
      sm_a = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
        min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
      sm_b = ShippingMode.create!(name: "Convencional", min_distance: 0, max_distance: 1500, 
        min_weight: 0, max_weight: 1000_000, fixed_fee: 3.00)
      sm_c = ShippingMode.create!(name: "Pequenas Distâncias", min_distance: 0, max_distance: 100, 
        min_weight: 0, max_weight: 10_000, fixed_fee: 3.50)
      service_order = ServiceOrder.create!(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 11_000,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 200,
        full_addresses_attributes: [{belonging_to: :recipient, 
          zip_code: '123456000', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12'},
          {belonging_to: :shipper,
          zip_code: '167456000', city: 'Curitiba', state: 'PR', address: 'Avenida Roxo, 95'}])
      
      shipping_modes = service_order.find_available_shipping_modes
      result = shipping_modes.include?(sm_c)
  
      expect(result).to be false
      
    end
  end
end
