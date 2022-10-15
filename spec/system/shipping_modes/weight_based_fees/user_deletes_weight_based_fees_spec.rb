require 'rails_helper'

describe 'Usuário deleta configuração de taxas de acordo com peso' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 50, fee_per_km: 5.50)
    sm.weight_based_fees.create!(min_weight: 51, max_weight: 100, fee_per_km: 6.50)

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com peso'
    click_on 'Deletar configuração'
    #Assert
    expect(page).not_to have_content('0')
    expect(page).not_to have_content('50')
    expect(page).not_to have_content('51')
    expect(page).not_to have_content('100')
    expect(page).not_to have_content('6,50')

  end
end