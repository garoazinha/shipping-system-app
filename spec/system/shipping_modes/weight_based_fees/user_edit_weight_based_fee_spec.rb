require 'rails_helper'

describe 'Usuário edita taxa baseado em peso' do
  it 'a partir de página de taxas' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: "mari@sistemadefrete.com.br",
                       password: 'password', role: :admin)
    sm = ShippingMode.create!(name: 'Convencional', min_weight: 1, max_weight: 10000,
                        min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                        description: "Modalidade de transporte convencional")
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 50, fee_per_km: 0.25)
    sm.weight_based_fees.create!(min_weight: 51, max_weight: 100, fee_per_km: 0.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Taxas de acordo com peso'
    within('table') do
      click_on 'Editar', match: :first
    end
    
    #Assert
    expect(page).to have_field('Taxa', with: 0.25)
  end
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: "mari@sistemadefrete.com.br",
                       password: 'password', role: :admin)
    sm = ShippingMode.create!(name: 'Convencional', min_weight: 1, max_weight: 10000,
                        min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                        description: "Modalidade de transporte convencional")
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 50, fee_per_km: 0.25)
    sm.weight_based_fees.create!(min_weight: 51, max_weight: 100, fee_per_km: 0.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Taxas de acordo com peso'
    within('table') do
      click_on 'Editar', match: :first
    end
    fill_in 'Taxa', with: 0.30
    click_on 'Atualizar'
    
    #Assert
    expect(page).to have_content('Configuração atualizada com sucesso')
    expect(page).to have_content('0,30')
    expect(page).not_to have_content('0,25')
  end

  it 'faltando dados' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: "mari@sistemadefrete.com.br",
                       password: 'password', role: :admin)
    sm = ShippingMode.create!(name: 'Convencional', min_weight: 1, max_weight: 10000,
                        min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                        description: "Modalidade de transporte convencional")
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 50, fee_per_km: 0.25)
    sm.weight_based_fees.create!(min_weight: 51, max_weight: 100, fee_per_km: 0.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Taxas de acordo com peso'
    within('table') do
      click_on 'Editar', match: :first
    end
    fill_in 'Taxa', with: ''
    click_on 'Atualizar'
    
    #Assert
    expect(page).to have_content('Configuração não pode ser atualizada')
    
    expect(page).not_to have_content('0,30')
  end
end