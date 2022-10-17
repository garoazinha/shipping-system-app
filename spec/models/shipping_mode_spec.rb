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

    it 'Distância mínima deve ser igual ou maior que zero' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 1, max_weight: 100_000,
                                 min_distance: -1, max_distance: 2000, fixed_fee: 1.50,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?


      #Assert
      expect(result).to be false
    end

    it 'Peso mínimo deve ser igual ou maior que zero' do
      #Arrange
      sm = ShippingMode.new(name: 'Convencional', min_weight: 0, max_weight: 100_000,
                                 min_distance: -1, max_distance: 2000, fixed_fee: 1.50,
                                 description: "Modalidade de transporte convencional")

      #Act
      result = sm.valid?

      #Assert
      expect(result).to be false
    end
  end

  describe 'Encontra-se dado' do
    it 'de preço de acordo com distância através de tabela' do
      sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
      sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 2.00)
      sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 5.00)
      
      fee = sm.find_distance_based_fee(distance: 100)

      expect(fee).to eq(2.00)
    end

    it 'de preço de acordo com peso através de tabela' do
      sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
      sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
      sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 30_000, fee_per_km:0.25)
      
      fee_per_km = sm.find_weight_based_fee(product_weight: 2_000)

      expect(fee_per_km).to eq(0.1)
    end

    it 'de prazo de acordo com distância através de tabela' do
      sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
      sm.delivery_times.create!(min_distance: 0, max_distance: 150, estimated_delivery_time: 24)
      sm.delivery_times.create!(min_distance: 151, max_distance: 500, estimated_delivery_time: 48)
    
      estimated_delivery_time = sm.find_estimated_delivery_time(distance: 100)

      expect(estimated_delivery_time).to eq(24)
    end

    it 'e calcula-se preço total' do
      sm = ShippingMode.create!(name: "Express", min_distance: 0, max_distance: 1000, 
                              min_weight: 0, max_weight: 500_000, fixed_fee: 5.00)
      sm.weight_based_fees.create!(min_weight: 0, max_weight: 10_000, fee_per_km: 0.10)
      sm.weight_based_fees.create!(min_weight: 10_001, max_weight: 30_000, fee_per_km:0.25)
      sm.distance_based_fees.create!(min_distance: 0, max_distance: 200, fee: 2.00)
      sm.distance_based_fees.create!(min_distance: 201, max_distance: 500, fee: 5.00)

      total_price = sm.total_price(distance: 100, product_weight: 1_000)

      expect(total_price).to eq(17.0)
    end
  end
end
