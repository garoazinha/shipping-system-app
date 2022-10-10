require 'rails_helper'


describe 'Usuário procura veículo' do
  it 'a partir da página de veículos' do
    #Arrange
    user = User.create(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :standard)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'

    #Assert
    expect(page).to have_field('Consulta de veículos')
    expect(page).to have_button('Buscar')
  end

  it 'se estiver autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Veículos'
    #Assert
    expect(current_path).to eq(new_user_session_path)

  end

  it 'e encontra um resultado' do
    #Arrange
    user = User.create(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :standard)
    car_a = Vehicle.create(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                          year: 2017, max_capacity: 1500, activity: :operational)
    car_b = Vehicle.create(plate_number: 'PRA0A10', model: 'Ducato', brand: 'Fiat',
                          year: 2018, max_capacity: 1300, activity: :maintenance)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    fill_in 'Consulta de veículos', with: 'BRA0Z21'
    click_on 'Buscar'

    #Assert
    expect(page).to have_content('Resultados da pesquisa: BRA0Z21')
    expect(page).to have_content('1 veículo encontrado')
    expect(page).to have_content('Sprinter')
    expect(page).to have_content('Mercedes-Benz')
    expect(page).to have_content('2017')
    expect(page).to have_content('Em operação')
    expect(page).not_to have_content('PRA0A10')
  end

  it 'e encontra vários resultados' do
    #Arrange
    user = User.create(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :standard)
    car_a = Vehicle.create(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                          year: 2017, max_capacity: 1500, activity: :operational)
    car_b = Vehicle.create(plate_number: 'BRA0A10', model: 'Ducato', brand: 'Fiat',
                          year: 2018, max_capacity: 1300, activity: :maintenance)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    fill_in 'Consulta de veículos', with: 'BRA'
    click_on 'Buscar'

    #Assert
    expect(page).to have_content('Resultados da pesquisa: BRA')
    expect(page).to have_content('2 veículos encontrados')
    expect(page).to have_content('Sprinter')
    expect(page).to have_content('Mercedes-Benz')
    expect(page).to have_content('2017')
    expect(page).to have_content('Em operação')
    expect(page).to have_content('BRA0A10')
    expect(page).to have_content('Ducato')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('2018')
    expect(page).to have_content('Em manutenção')
    
  end 
end