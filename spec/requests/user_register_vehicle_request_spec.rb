require 'rails_helper'


describe 'Usuário tenta registrar novo veículo' do
  it 'a partir de rota de novo veículos e não é administrador' do
    #Arrange
    user = User.create!(name: 'Pedro B', email: 'pedro@sistemadefrete.com.br',
      password: 'password', role: :standard)

    #Act
    login_as(user)
    get(new_vehicle_path)
    #Assert
    expect(response).to redirect_to(root_path)
  end

  it 'a partir de rota de novo veículos e não é autenticado' do
    #Arrange
    #Act
    get(new_vehicle_path)
    #Assert
    expect(response).to redirect_to(new_user_session_path)
  end
end