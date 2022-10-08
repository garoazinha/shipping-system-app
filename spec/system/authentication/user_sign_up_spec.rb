require 'rails_helper'

describe 'Usuário faz cadastro' do
  it 'com sucesso' do
    #Arrange
    #Act
    visit root_path
    click_on 'Login'
    click_on 'Inscreva-se'
    fill_in 'Nome', with: 'Mariana Souza'
    fill_in 'E-mail', with: 'mari@sistemadefrete.com.br'
    fill_in 'Senha', with: 'pass1234'
    fill_in 'Confirme sua senha', with: 'pass1234'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Cadastro efetuado com sucesso')
    expect(page).to have_button('Sair')
    expect(page).to have_content('Mariana Souza')
    user = User.last
    expect(user.name).to eq('Mariana Souza')
  end

  it 'e utiliza e-mail inadequado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Login'
    click_on 'Inscreva-se'
    fill_in 'Nome', with: 'Mariana Souza'
    fill_in 'E-mail', with: 'mari@email.com'
    fill_in 'Senha', with: 'pass1234'
    fill_in 'Confirme sua senha', with: 'pass1234'
    click_on 'Enviar'
    #Assert
    expect(page).not_to have_content('Cadastro efetuado com sucesso')
    expect(page).to have_content('E-mail deve ser do domínio @sistemadefrete.com.br')
    expect(page).not_to have_button('Sair')
    expect(page).not_to have_content('Mariana Souza')

  end
end
