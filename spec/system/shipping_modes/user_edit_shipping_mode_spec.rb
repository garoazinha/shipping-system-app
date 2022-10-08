require 'rails_helper'

describe 'Usuário edita modalidade de transporte' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mariana S', email: 'mari@sistemadefrete.com.br',
                        password: 'password', role: :admin)
    sm = ShippingMode.create(name: 'Convencional', min_weight: 1, max_weight: 10000,
                          min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                          description: "Modalidade de transporte convencional")

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Editar'
    fill_in 'Taxa fixa', with: '1.20'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Modalidade de transporte atualizada com sucesso')
    expect(page).to have_content('Convencional')
    expect(page).to have_content('Taxa fixa: R$1,20')
  end

  it 'faltando informações obrigatórias' do
    #Arrange
    user = User.create!(name: 'Mariana S', email: 'mari@sistemadefrete.com.br',
                        password: 'password', role: :admin)
    sm = ShippingMode.create(name: 'Convencional', min_weight: 1, max_weight: 10000,
      min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
      description: "Modalidade de transporte convencional")

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Editar'
    fill_in 'Taxa fixa', with: ''
    click_on 'Enviar'
    
    #Assert
    expect(page).to have_content("Modalidade de transporte não pode ser atualizada")
    expect(page).to have_content("Taxa fixa não pode ficar em branco")

  end

  it 'e página de edição tem campos preenchidos com informações antigas' do
    #Arrange
    user = User.create!(name: 'Mariana S', email: 'mari@sistemadefrete.com.br',
                        password: 'password', role: :admin)
    sm = ShippingMode.create(name: 'Convencional', min_weight: 1, max_weight: 10000,
                          min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                          description: "Modalidade de transporte convencional")

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Editar'
    
    #Assert
    expect(page).to have_field('Nome', with: 'Convencional')
    expect(page).to have_field('Distância mínima de serviço', with: '1')
    expect(page).to have_field('Distância máxima de serviço', with: '2000')
  end

  it 'e não é administrador' do
    #Arrange
    user = User.create!(name: 'Mariana S', email: 'mari@sistemadefrete.com.br',
      password: 'password', role: :standard)
    sm = ShippingMode.create(name: 'Convencional', min_weight: 1, max_weight: 10000,
                            min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                            description: "Modalidade de transporte convencional")

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'

    #Assert
    expect(page).not_to have_link('Editar')
    
  end
end