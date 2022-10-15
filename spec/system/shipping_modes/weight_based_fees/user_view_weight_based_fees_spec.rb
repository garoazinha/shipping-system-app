require 'rails_helper'

describe 'Usuário visualiza dados de taxas de acordo com peso' do
  
  it 'a partir da página da modalidade de transporte' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: "mari@sistemadefrete.com.br",
                       password: 'password', role: :standard)
    sm = ShippingMode.create!(name: 'Convencional', min_weight: 1, max_weight: 10000,
                        min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                        description: "Modalidade de transporte convencional")
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 60, fee_per_km: 0.25)
    sm.weight_based_fees.create!(min_weight: 61, max_weight: 100, fee_per_km: 0.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Taxas de acordo com peso'
    #Assert
    expect(page).to have_content('0,25')
    expect(page).to have_content('0,50')
    expect(page).to have_content('60')
    expect(page).to have_content('61')
    expect(page).to have_content('Peso mínimo')
    expect(page).to have_content('Peso máximo')
  end
end