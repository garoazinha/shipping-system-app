require 'rails_helper'

RSpec.describe DeliveryDatum, type: :model do
  describe "valido?" do
    it 'veículo deve fazer parte dos veículos operacionais para modalidade de transporte' do
      sm = ShippingMode.create!(name: "Pequenas distâncias", min_distance: 0, max_distance: 50, 
                                min_weight: 0, max_weight: 10_000, fixed_fee: 3.50)
      vehicle = Vehicle.create!(plate_number: "ABC1234", max_capacity: 100_000,
                                 model: "Pop 101i", brand: "Honda", year: 2015, activity: :operational)
      
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
      delivery = service_order.build_delivery_datum(shipping_mode: sm, vehicle: vehicle,
                                                   total_price: 3.50, estimated_delivery_time: 24, 
                                                   creation_date: Time.now,
                                                   end_date: Time.now + 24.hours)

      result = delivery.valid?

      expect(result).to be false
    end
  end
end
