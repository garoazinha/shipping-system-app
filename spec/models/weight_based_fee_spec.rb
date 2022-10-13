require 'rails_helper'

RSpec.describe WeightBasedFee, type: :model do
  describe 'valido?' do
    it 'Distância mínima é obrigatório' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_distance: nil, max_distance: 100, fee_per_km: 0.25 )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Distância máxima é obrigatório' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_distance: 0, max_distance: nil, fee_per_km: 0.25 )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Taxa é obrigatório' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_distance: 0, max_distance: 100, fee_per_km: nil )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end
    it 'Distância máxima deve ser maior que distância mínima' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_distance: 100, max_distance: 0, fee_per_km: 0.25 )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Distância mínima deve ser maior ou igual que zero' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_distance: -1, max_distance: 200, fee_per_km: 0.25 )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Intervalos não devem se interceptar' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      sm.weight_based_fees.create!(min_distance: 0, max_distance: 200, fee_per_km: 0.25 )
      smwbf = sm.weight_based_fees.build(min_distance: 150, max_distance: 250, fee_per_km: 0.45 )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end
  end
end
