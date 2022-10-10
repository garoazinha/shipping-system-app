require 'rails_helper'

describe 'Usuário vê veículo em página de veículos' do
  it 'a partir do menu' do
    #Arrange
    user = User.create(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br', 
                        password: 'password', role: :standard)
    car_a = Vehicle.create(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                           year: 2017, max_capacity: 1500, activity: :operational)
    
    car_b = Vehicle.create(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
                        year: 2018, max_capacity: 1300, activity: :maintenance)

    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    #Assert
    expect(page).to have_content('BRA0Z21')
    expect(page).to have_content('Em operação')
    expect(page).to have_content('PRA0A10')
    expect(page).to have_content('Em manutenção')



  end
end