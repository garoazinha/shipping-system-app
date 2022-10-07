require 'rails_helper'

RSpec.describe ShippingMode, type: :model do
  describe 'valido?' do
    it 'Nome deve ser obrigatório' do
      #Arrange
      sm = ShippingMode.new(name: '', min_weight: 1, max_weight: 10000,
                                 min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Peso minimo deve ser obrigatório' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: nil, max_weight: 10000,
                                 min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Peso máximo deve ser obrigatório' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 1, max_weight: nil,
                                 min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Distância mínima deve ser obrigatória' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 1, max_weight: 100_000,
                                 min_distance: nil, max_distance: 2000, fixed_fee: 1.00,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Distância máxima deve ser obrigatório' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 1, max_weight: 100_000,
                                 min_distance: 1, max_distance: nil, fixed_fee: 1.00,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Taxa fixa deve ser obrigatória' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 1, max_weight: 100_000,
                                 min_distance: 1, max_distance: 2000, fixed_fee: nil,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Taxa fixa deve ser maior que zero' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 1, max_weight: 100_000,
                                 min_distance: 1, max_distance: 2000, fixed_fee: 0,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Distância mínima deve ser maior que zero' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 1, max_weight: 100_000,
                                 min_distance: 0, max_distance: 2000, fixed_fee: 1.50,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Peso mínimo deve ser maior que zero' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 0, max_weight: 100_000,
                                 min_distance: 1, max_distance: 2000, fixed_fee: 1.50,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?

      #Assert
      expect(result).to be false
    end
  end
end
