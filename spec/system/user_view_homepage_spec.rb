require 'rails_helper'

describe 'Usuário visita página inicial' do
  it 'e vê título da aplicação' do
    #Arrange
    #Act
    visit root_path
    #Assert
    expect(page).to have_content('Sistema de Fretes Mari&Mari')

  end
end