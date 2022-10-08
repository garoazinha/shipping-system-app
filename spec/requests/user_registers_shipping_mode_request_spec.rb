require 'rails_helper'

describe 'Usuário tenta cadastrar modalidade de transporte' do
  it 'a partir de rota de nova modalidade de transporte e não é administrador' do
    #Arrange
    user = User.create!(name: 'Pedro B', email: 'pedro@sistemadefrete.com.br',
      password: 'password', role: :standard)

    #Act
    login_as(user)
    get(new_shipping_mode_path)
    #Assert
    expect(response).to redirect_to(root_path)
  end
  
  it 'a partir de requisição e não é administrador' do
    #Arrange
    user = User.create!(name: 'Pedro B', email: 'pedro@sistemadefrete.com.br',
                      password: 'password', role: :standard)

    #Act
    login_as(user)
    post(shipping_modes_path, params: { shipping_mode: {name: 'Exp', min_weight: 1, max_weight: 10000,
                                min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                                description: "Modalidade de transporte convencional" } } )
    #Assert
    expect(response).to redirect_to(root_path)
  end

end