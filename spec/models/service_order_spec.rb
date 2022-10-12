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
end
