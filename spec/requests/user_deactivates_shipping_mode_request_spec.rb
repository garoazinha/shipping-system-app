require 'rails_helper'

describe 'Usuário desativa modalidade de transporte' do
  it 'e não é administrador' do
    #Arrange
    user = User.create!(name: 'Pedro B', email: 'pedro@sistemadefrete.com.br',
                        password: 'password', role: :standard)
    sm = ShippingMode.create(name: 'Convencional', min_weight: 1, max_weight: 10000,
                              min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                              description: "Modalidade de transporte convencional")

    #Act
    login_as(user)
    post(deactivate_shipping_mode_path(sm.id), params: { shipping_mode: { status: :inactive } } )
    #Assert
    expect(response).to redirect_to(root_path)
  end
end