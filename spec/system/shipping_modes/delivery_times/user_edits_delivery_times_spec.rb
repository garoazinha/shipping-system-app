require 'rails_helper' 
describe 'Usuário edita prazos cadastrados' do
  it 'a partir da página de prazos' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.delivery_times.create!(min_distance: 0, max_distance: 50, estimated_delivery_time: 24)
    sm.delivery_times.create!(min_distance: 51, max_distance: 100, estimated_delivery_time: 48)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Prazos'
    within('table') do
      click_link 'Editar', match: :first
    end
    #Assert
    expect(page).to have_field('Prazo estimado')


  end
  it 'a partir da página de prazos' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.delivery_times.create!(min_distance: 0, max_distance: 50, estimated_delivery_time: 24)
    sm.delivery_times.create!(min_distance: 51, max_distance: 100, estimated_delivery_time: 48)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Prazos'
    within('table') do
      click_link 'Editar', match: :first
    end
    fill_in 'Prazo estimado', with: 12
    click_on 'Atualizar'
    #Assert
    expect(page).to have_content('Prazos para Express')
    expect(page).to have_content('12')
    expect(current_path).to eq(shipping_mode_delivery_times_path(sm.id))


  end
end