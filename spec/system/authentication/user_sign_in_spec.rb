require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    User.create!(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br',
                 password: 'pass123', role: :standard)
    #Act
    visit root_path
    click_on 'Login'
    fill_in 'E-mail', with: 'mari@sistemadefrete.com.br'
    fill_in 'Senha', with: 'pass123'
    click_on 'Entrar'

    #Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_button('Sair')
    expect(page).to have_content('Mariana Souza')
    
    
  end

  it 'e faz logout' do
    #Arrange
    User.create!(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br',
      password: 'pass123', role: :standard)
    #Act
    visit root_path
    click_on 'Login'
    fill_in 'E-mail', with: 'mari@sistemadefrete.com.br'
    fill_in 'Senha', with: 'pass123'
    click_on 'Entrar'
    within('nav') do
      click_on 'Sair'
    end

    #Assert
    expect(page).to have_content('Logout efetuado com sucesso')
    expect(page).to have_link 'Login'
    expect(page).not_to have_content 'Mariana Souza'
    expect(current_path).to eq (root_path)

  end 
end