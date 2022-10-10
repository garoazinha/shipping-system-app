require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'valido?' do
    it 'Placa de identificação é obrigatória' do
      #Arrange
      car = Vehicle.new(plate_number: '', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2016, max_capacity: 1500)
      #Act
      result = car.valid?
      #Assert
      expect(result).to be false
      
    end

    it 'Modelo é obrigatório' do
      #Arrange
      car = Vehicle.new(plate_number: 'BRA0S21', model: '', brand: 'Mercedes-Benz',
                        year: 2016, max_capacity: 1500)
      #Act
      result = car.valid?
      #Assert
      expect(result).to be false
      
    end
    it 'Marca é obrigatória' do
      #Arrange
      car = Vehicle.new(plate_number: 'BRA0S21', model: 'Sprinter', brand: '',
                        year: 2016, max_capacity: 1500)
      #Act
      result = car.valid?
      #Assert
      expect(result).to be false
      
    end
    it 'Ano é obrigatório' do
      #Arrange
      car = Vehicle.new(plate_number: 'BRA0S21', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: '', max_capacity: 1500)
      #Act
      result = car.valid?
      #Assert
      expect(result).to be false
      
    end
    it 'Capacidade máxima é obrigatória' do
      #Arrange
      car = Vehicle.new(plate_number: 'BRA0S21', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2016, max_capacity: '')
      #Act
      result = car.valid?
      #Assert
      expect(result).to be false
      
    end

    it 'Placa do veículo pode ter formato ABC1234 ou ABC1D23' do

      #Arrange
      car = Vehicle.new(plate_number: 'BR30021', model: 'Sprinter', brand: 'Mercedes-Benz',
                      year: 2016, max_capacity: 1500)
      #Act
      result = car.valid?
      #Assert
      expect(result).to be false
      
    end

    it 'Placa do veículo pode ter formato ABC1234' do

      #Arrange
      car = Vehicle.new(plate_number: 'BRA0021', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2016, max_capacity: 1500)
      #Act
      result = car.valid?
      #Assert
      expect(result).to be true
      
    end

    it 'Placa do veículo pode ter formato ABC1D23' do

      #Arrange
      car = Vehicle.new(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2016, max_capacity: 1500)
      #Act
      result = car.valid?
      #Assert
      expect(result).to be true
    end

    it 'Ano não pode ser maior que ano atual' do

      #Arrange
      car = Vehicle.new(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                        year: 2023, max_capacity: 1500)
      #Act
      result = car.valid?
      #Assert
      expect(result).to be false
    end

    it 'Placa de identificação deve ser únicos' do

      #Arrange
      car = Vehicle.create!(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                           year: 2020, max_capacity: 1500)
      other_car = Vehicle.new(plate_number: 'BRA0Z21', model: 'Ducato', brand: 'Fiat',
                               year: 2020, max_capacity: 1500)
      #Act
      result = other_car.valid?
      #Assert
      expect(result).to be false
    end

  end
end
