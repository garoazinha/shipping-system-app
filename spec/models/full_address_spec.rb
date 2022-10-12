require 'rails_helper'

RSpec.describe FullAddress, type: :model do
  describe 'valido?' do
    it 'CEP deve ser do formato 000000000' do
      #Arrange
      new_service_order = ServiceOrder.new(product_code: 'ABC1234', product_width: 20,
        product_height: 20, product_depth: 10, product_weight: 450,
        recipient_name: 'Maria Silva', recipient_registration_number: '01234567899', distance: 50)
      s_address = new_service_order.full_addresses.build(belonging_to: :recipient, 
          zip_code: 'abc', city: 'São Paulo', state: 'SP', address: 'Avenida Amarelo, 12')


      #Act
      
      result= s_address.valid?
      #Assert
      expect(result).to be false
    end

  end
end
