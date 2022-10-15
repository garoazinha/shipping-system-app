require 'rails_helper'

RSpec.describe WeightBasedFee, type: :model do
  describe 'valido?' do
    it 'Peso mínimo é obrigatório' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_weight: nil, max_weight: 10, fee_per_km: 0.25 )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Peso máximo é obrigatório' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_weight: 0, max_weight: nil, fee_per_km: 0.25 )
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
      smwbf = sm.weight_based_fees.build(min_weight: 0, max_weight: 10, fee_per_km: nil )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end
    it 'Peso máximo deve ser maior que distância mínima' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_weight: 10, max_weight: 0, fee_per_km: 0.25 )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Peso mínimo deve ser maior ou igual que zero' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50)
      smwbf = sm.weight_based_fees.build(min_weight: -1, max_weight: 10, fee_per_km: 0.25 )
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
      sm.weight_based_fees.create!(min_weight: 0, max_weight: 10, fee_per_km: 0.25 )
      smwbf = sm.weight_based_fees.build(min_weight: 10, max_weight: 20, fee_per_km: 0.45 )
      #Act
      result = smwbf.valid?
      #Assert
      expect(result).to be false
    end
  end
end
