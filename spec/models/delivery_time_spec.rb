require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe 'valido?' do
    it 'Distância máxima tem de ser maior que distância mínima' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      smdt = sm.delivery_times.build(min_distance: 20, max_distance: 0, estimated_delivery_time: 24 )
      #Act
      result = smdt.valid?
      #Assert
      expect(result).to be false
    end

    it 'Prazo deve ser único' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      sm.delivery_times.create!(min_distance: 0, max_distance: 50, estimated_delivery_time: 24 )
      smdt = sm.delivery_times.new(min_distance: 51, max_distance: 100, estimated_delivery_time: 24 )
      #Act
      result = smdt.valid?
      #Assert
      expect(result).to be false
    end

    it 'Intervalos não devem se interceptar' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      sm.delivery_times.create!(min_distance: 0, max_distance: 50, estimated_delivery_time: 24 )
      smdt = sm.delivery_times.new(min_distance: 49, max_distance: 100, estimated_delivery_time: 36 )
      #Act
      result = smdt.valid?
      #Assert
      expect(result).to be false
    end
    
  end
end
