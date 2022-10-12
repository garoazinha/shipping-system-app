require 'rails_helper'

RSpec.describe DistanceBasedFee, type: :model do
  describe 'valido?' do
    it 'Distância mínima é obrigatório' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      smdbf = sm.distance_based_fees.new(min_distance: nil, max_distance: 100, fee: 5.50)
      #Act
      result = smdbf.valid?
      #Assert
      expect(result).to be false
    end

    

    it 'Distância máxima é obrigatório' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      smdbf = sm.distance_based_fees.new(min_distance: 0, max_distance: nil, fee: 5.50)
      #Act
      result = smdbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Taxa é obrigatório' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      smdbf = sm.distance_based_fees.new(min_distance: 0, max_distance: 100, fee: nil)
      #Act
      result = smdbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Distância mínima deve ser maior ou igual a zero' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      smdbf = sm.distance_based_fees.new(min_distance: -1, max_distance: 100, fee: 5.50)
      #Act
      result = smdbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Taxa deve ser maior que 0' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      smdbf = sm.distance_based_fees.new(min_distance: 0, max_distance: 100, fee: 0)
      #Act
      result = smdbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Distância máxima deve ser maior que distância mínima' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      smdbf = sm.distance_based_fees.new(min_distance: 100, max_distance: 0, fee: 5.50)
      #Act
      result = smdbf.valid?
      #Assert
      expect(result).to be false
    end

    it 'Intervalos não devem se interceptar' do
      #Arrange
      sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                                min_weight: 1, max_weight: 20000,
                                fixed_fee: 1.50, status: :active)
      sm.distance_based_fees.create!(min_distance: 0, max_distance: 100, fee: 5.50)
      smdbf = sm.distance_based_fees.new(min_distance: 100, max_distance: 150, fee: 6.50)
      #Act
      result = smdbf.valid?
      #Assert
      expect(result).to be false
    end
  end
end
