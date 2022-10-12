require 'rails_helper' 
describe 'Usuário edita taxas de acordo com distância' do
  it 'a partir da página de taxas' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 50, fee: 5.50)
    sm.distance_based_fees.create!(min_distance: 51, max_distance: 100, fee: 6.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com distância'
    within('table') do
      click_link 'Editar', match: :first
    end
    #Assert
    expect(page).to have_field('Taxa', with: 5.5)


  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 50, fee: 5.50)
    sm.distance_based_fees.create!(min_distance: 51, max_distance: 100, fee: 6.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com distância'
    within('table') do
      click_link 'Editar', match: :first
    end
    fill_in 'Taxa', with: 6.00
    click_on 'Atualizar'
    #Assert
    expect(page).to have_content('6,00')


  end

  it 'e dados estão faltando' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.distance_based_fees.create!(min_distance: 0, max_distance: 50, fee: 5.50)
    sm.distance_based_fees.create!(min_distance: 51, max_distance: 100, fee: 6.50)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Taxas de acordo com distância'
    within('table') do
      click_link 'Editar', match: :first
    end
    fill_in 'Taxa', with: '-1'
    click_on 'Atualizar'
    #Assert
    expect(page).to have_content('Taxa não pode ser atualizada')
    


  end
  
  
end