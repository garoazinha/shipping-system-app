require 'rails_helper'

describe 'Usuário registra ordem de serviço' do
  it 'a partir de página' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :admin)

    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Adicionar ordem de serviço'

    #Assert
    within('div.product') do
      
      expect(page).to have_field('Código')
      expect(page).to have_field('Largura')
      expect(page).to have_field('Altura')
      expect(page).to have_field('Profundidade')
      expect(page).to have_field('Peso')
      
    end
    within('div.shipper') do
      
      expect(page).to have_field('Endereço')
      expect(page).to have_field('Cidade')
      expect(page).to have_field('Estado')
      expect(page).to have_field('CEP')
    end
    within('div.recipient') do

      expect(page).to have_field('Nome')
      expect(page).to have_field('CPF')
      expect(page).to have_field('Endereço')
      expect(page).to have_field('Cidade')
      expect(page).to have_field('Estado')
      expect(page).to have_field('CEP')
    end
    expect(page).to have_field('Distância')

    
  end

  it 'com sucesso' do

    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :admin)

    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Adicionar ordem de serviço'
    within('div.product') do
      fill_in 'Código', with: 'ABC123456'
      fill_in 'Largura', with: 10
      fill_in 'Altura', with: 20
      fill_in 'Profundidade', with: 30
      fill_in 'Peso', with: 100
    end
    within('div.shipper') do
      fill_in 'Endereço', with: 'Rua da Amizade, 57'
      fill_in 'Cidade', with: 'São Paulo'
      fill_in 'Estado', with: 'SP'
      fill_in 'CEP', with: '675000000'
    end
    within('div.recipient') do
      fill_in 'Nome', with: 'Mariana Souza'
      fill_in 'CPF', with: '0994006518'
      fill_in 'Endereço', with: 'Rua do Ódio, 76'
      fill_in 'Cidade', with: 'São Paulo'
      fill_in 'Estado', with: 'SP'
      fill_in 'CEP', with: '335000000'
    end
    fill_in 'Distância', with: 15
    click_on 'Enviar'
    #assert
    expect(page).to have_content('10cm x 20cm x 30cm')
    expect(page).to have_content('Rua da Amizade, 57')

    expect(page).to have_content('Rua do Ódio, 76')
  

  end

  it 'só se for administrador' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :standard)

    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    #Assert
    expect(page).not_to have_link('Adicionar ordem de serviço')
    
  end

  it 'sem dados de endereç' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password', role: :admin)

    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Adicionar ordem de serviço'
    within('div.product') do
      fill_in 'Código', with: 'ABC123456'
      fill_in 'Largura', with: 10
      fill_in 'Altura', with: 20
      fill_in 'Profundidade', with: 30
      fill_in 'Peso', with: 100
    end
    within('div.shipper') do
      fill_in 'Endereço', with: ''
      fill_in 'Cidade', with: ''
      fill_in 'Estado', with: 'SP'
      fill_in 'CEP', with: '675000000'
    end
    within('div.recipient') do
      fill_in 'Nome', with: 'Mariana Souza'
      fill_in 'CPF', with: '0994006518'
      fill_in 'Endereço', with: 'Rua do Ódio, 76'
      fill_in 'Cidade', with: 'São Paulo'
      fill_in 'Estado', with: 'SP'
      fill_in 'CEP', with: '335000000'
    end
    fill_in 'Distância', with: 15
    click_on 'Enviar'
    #assert
    expect(page).to have_content('Ordem de serviço não pode ser criada')
    expect(page).to have_field('Nome', with: 'Mariana Souza')

  end
end