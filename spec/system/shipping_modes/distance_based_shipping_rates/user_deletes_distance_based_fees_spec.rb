require 'rails_helper'

describe 'Usuário deleta configuração de taxas de acordo com distância' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.delivery_times.create!(min_distance: 0, max_distance: 50, estimated_delivery_time: 5.50)
    sm.delivery_times.create!(min_distance: 51, max_distance: 100, estimated_delivery_time: 6.50)

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com distância'
    click_on 'Deletar configuração'
    #Assert
    expect(page).not_to have_content('0')
    expect(page).not_to have_content('50')
    expect(page).not_to have_content('51')
    expect(page).not_to have_content('100')

  end
end