require 'rails_helper'

describe 'Usuário registra nova configuração de preços para peso' do
  it 'em página de taxas de acordo com distância' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com distância'


    #Assert
    expect(page).to have_field('Distância mínima')
    expect(page).to have_field('Distância máxima')
    expect(page).to have_field('Taxa')

  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com distância'
    fill_in 'Distância mínima', with: 50
    fill_in 'Distância máxima', with: 100
    fill_in 'Taxa', with: 6.50
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Nova configuração de preço salva com sucesso')
    expect(page).to have_content('50')
    expect(page).to have_content('100')
    expect(page).to have_content('6,50')
    

  end
  it 'e intervalos se interceptam' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 100, fee: 6.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com distância'
    fill_in 'Distância mínima', with: 50
    fill_in 'Distância máxima', with: 120
    fill_in 'Taxa', with: 8.50
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Configuração não pode ser salva')
    expect(page).not_to have_content('Nova configuração de preço salva com sucesso')
    expect(page).not_to have_content('120')
    expect(page).not_to have_content('8,50')
    
    

  end

  it 'só se for administrador' do
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                        role: :standard)
    sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 50, fee:5.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com distância'
    #Assert
    expect(page).to have_content('50')
    expect(page).not_to have_field('Distância mínima')
    expect(page).not_to have_field('Distância máxima')
    

    
  end
end