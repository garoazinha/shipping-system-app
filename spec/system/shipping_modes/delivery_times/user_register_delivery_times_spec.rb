require 'rails_helper' 

describe 'Usuário registra tabela de prazos' do
  it 'a partir de página de modalidade de transporte' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Prazos'
    #Assert

    expect(page).to have_field('Distância mínima')
    expect(page).to have_field('Distância máxima')
    expect(page).to have_field('Prazo estimado')
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                         role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                              min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)

    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Prazos'
    fill_in 'Distância mínima', with: 0
    fill_in 'Distância máxima', with: 50
    fill_in 'Prazo estimado', with: 24
    click_on 'Enviar'

    #Assert

    expect(page).to have_content('Nova configuração salva com sucesso')
    expect(page).to have_content('0')
    expect(page).to have_content('50')
    expect(page).to have_content('24')
    expect(page).to have_field('Distância mínima')
    expect(page).to have_field('Distância máxima')
    expect(page).to have_field('Prazo estimado')
  end
  
  it 'e intervalos se intersectam' do
    #Arrange
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                       role: :admin)
    sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                             min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.delivery_times.create!(min_distance: 0, max_distance: 50, estimated_delivery_time: 24)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Prazos'
    fill_in 'Distância mínima', with: 40
    fill_in 'Distância máxima', with: 60
    fill_in 'Prazo estimado', with: 30
    click_on 'Enviar'

    #Assert
    expect(page).not_to have_content('40')
    expect(page).to have_content('Não foi possível configurar prazo')

 

    
  end

  it 'só se for administrador' do
    user = User.create!(name: 'Mari', email: 'mari@sistemadefrete.com.br', password: 'password',
                        role: :standard)
    sm = ShippingMode.create!(name: 'Express', min_distance: 0, max_distance: 1000,
                min_weight: 1, max_weight: 20000, fixed_fee: 1.50, status: :active)
    sm.delivery_times.create!(min_distance: 0, max_distance: 50, estimated_delivery_time: 24)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Express'
    click_on 'Prazos'
    #Assert
    expect(page).to have_content('50')
    expect(page).not_to have_field('Distância mínima')
    expect(page).not_to have_field('Distância máxima')
    

    
  end
end