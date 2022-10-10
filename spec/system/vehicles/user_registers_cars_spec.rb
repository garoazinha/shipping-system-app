require 'rails_helper'

describe 'Usuário cadastra veículo' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br',
                        password: 'password', role: :admin)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Adicionar veículo'
    fill_in 'Placa de identificação', with: 'AZG4497'
    fill_in 'Modelo', with: 'Ducato'
    fill_in 'Marca', with: 'Fiat'
    fill_in 'Ano', with: '2012'
    fill_in 'Capacidade máxima de carga', with: '1500'
    click_on 'Enviar'
    
    #Assert
    expect(page).to have_content('Veículo salvo com sucesso')
    expect(page).to have_content('AZG4497')
    expect(page).to have_content('Ducato')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('2012')
    expect(page).to have_content('Capacidade máxima de carga: 1500 kg')

    expect(page).to have_content('Em operação')
  end

  it 'e não adiciona informações obrigatórias' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br',
                        password: 'password', role: :admin)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Adicionar veículo'
    fill_in 'Placa de identificação', with: ''
    fill_in 'Modelo', with: 'Ducato'
    fill_in 'Marca', with: 'Fiat'
    fill_in 'Ano', with: ''
    fill_in 'Capacidade máxima de carga', with: '1500'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Veículo não pode ser salvo')
    expect(page).to have_field('Modelo', with: 'Ducato')
    expect(page).to have_field('Marca', with: 'Fiat')
    expect(page).to have_content('Placa de identificação não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')

    
  end

  it 'só se for administrador' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: 'mari@sistemadefrete.com.br',
                        password: 'password', role: :standard)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    #Assert
    expect(page).not_to have_link 'Adicionar veículo'
    
  end
end