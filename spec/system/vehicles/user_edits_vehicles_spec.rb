require 'rails_helper'

describe 'Usuário edita informação de veículos' do
  it 'a partir da página de detalhes do veículo' do
    #Arrange
    user = User.create(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br', 
                      password: 'password', role: :admin)
    car_a = Vehicle.create(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                          year: 2017, max_capacity: 1500, activity: :operational)

    car_b = Vehicle.create(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
                          year: 2018, max_capacity: 1300, activity: :maintenance)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'BRA0Z21'
    click_on 'Editar'
   
    #Assert
    expect(current_path).to eq (edit_vehicle_path(car_a.id))
    expect(page).to have_field('Marca', with: 'Mercedes-Benz')
    expect(page).to have_field('Placa de identificação', with: 'BRA0Z21')

  end

  it 'com sucesso' do
    #Arrange
    user = User.create(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br', 
                      password: 'password', role: :admin)
    car_a = Vehicle.create(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                           year: 2017, max_capacity: 1500, activity: :operational)

    car_b = Vehicle.create(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
                         year: 2018, max_capacity: 1300, activity: :maintenance)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'BRA0Z21'
    click_on 'Editar'
    fill_in 'Ano', with: '2019'
    fill_in 'Placa de identificação', with: 'BRA0C21'
    click_on 'Enviar'
    #Assert

    expect(page).to have_content('Veículo atualizado com sucesso')
    expect(page).to have_content('BRA0C21')
    expect(page).to have_content('2019')
    expect(page).not_to have_content('BRA0Z21')
    expect(page).not_to have_content('2017')
    
  end
  
  it 'com informações obrigatórias em falta' do
    #Arrange
    user = User.create(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br', 
                      password: 'password', role: :admin)
    car_a = Vehicle.create(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                           year: 2017, max_capacity: 1500, activity: :operational)

    car_b = Vehicle.create(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
                         year: 2018, max_capacity: 1300, activity: :maintenance)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'BRA0Z21'
    click_on 'Editar'
    fill_in 'Ano', with: ''
    fill_in 'Placa de identificação', with: ''
    click_on 'Enviar'
    #Assert

    expect(page).to have_content('Veículo não pode ser atualizado')
    expect(page).to have_content('Placa de identificação não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    
    
  end

  it 'trocando veículo de operacional para em manutenção' do
     #Arrange
    user = User.create(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br', 
                      password: 'password', role: :admin)
    car_a = Vehicle.create(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                           year: 2017, max_capacity: 1500, activity: :operational)

    car_b = Vehicle.create(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
                         year: 2018, max_capacity: 1300, activity: :maintenance)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'BRA0Z21'
    click_on 'Editar'
    choose option: :maintenance
    click_on 'Enviar'
    #assert
    expect(page).to have_content('Status: Em manutenção')
    
  end
end

