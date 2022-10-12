require 'rails_helper'

describe 'Usuário tenta editar prazos para modalidade de transporte' do
  it 'e não é administrador' do
    #Arrange
    user = User.create!(name: 'Pedri', email: 'pedro@sistemadefrete.com.br', password: 'password', role: :standard)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                        min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    dt_a = sm.delivery_times.create!(min_distance: 0, max_distance: 50, estimated_delivery_time: 24)
    dt_b = sm.delivery_times.create!(min_distance: 51, max_distance: 100, estimated_delivery_time: 48) 
    #Act
    login_as(user)
    get(edit_shipping_mode_delivery_time_path(sm.id, dt_a.id))
    #Assert
    expect(response).to redirect_to(root_path)

  end
end