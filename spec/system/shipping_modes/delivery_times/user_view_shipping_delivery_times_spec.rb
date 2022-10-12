require 'rails_helper' 

describe 'Usuário visualiza tabela de prazos' do
  it 'a partir de página de modalidade de transporte' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :standard)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.delivery_times.create!(min_distance: 0, max_distance: 100, estimated_delivery_time: 24)
    sm.delivery_times.create!(min_distance: 101, max_distance: 200, estimated_delivery_time: 36)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Prazos'
    #Assert
    within('table') do
      expect(page).to have_content('Distância mínima')
      expect(page).to have_content('Distância máxima')
      expect(page).to have_content('0')
      expect(page).to have_content('100')
      expect(page).to have_content('24')
      expect(page).to have_content('101')
      expect(page).to have_content('200')
      expect(page).to have_content('36')
    end
  end
end