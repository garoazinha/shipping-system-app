require 'rails_helper'

describe 'Usuário desassocia modalidade de transporte para veículo' do
  it 'e modalidade de transporte já está habilitada' do
    #Arrange
    sm_a = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                         min_weight: 1, max_weight: 10000, fixed_fee: 1)
    sm_b = ShippingMode.create!(name: 'Convencional', min_distance: 1, max_distance: 3000,
                         min_weight: 1, max_weight: 100000, fixed_fee: 0.5)
    user = User.create(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br', 
                      password: 'password', role: :admin)
    car = Vehicle.create(plate_number: 'BRA0Z21', model: 'Sprinter', brand: 'Mercedes-Benz',
                           year: 2017, max_capacity: 1500, activity: :operational)
    
    VehicleShippingMode.create!(vehicle_id: car.id, shipping_mode_id: sm_a.id)

    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'BRA0Z21'
    click_on 'Desabilitar'

    #Assert
    expect(page).to have_content('Modalidade de transporte desabilitada com sucesso')
    expect(page).not_to have_content('Express')
  end
  
end
