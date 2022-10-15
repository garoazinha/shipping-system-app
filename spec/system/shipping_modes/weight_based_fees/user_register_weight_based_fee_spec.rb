require 'rails_helper' 

describe 'Usuário registra taxas de acordo com peso' do
  it 'a partir de página de taxas de acordo com peso' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: "mari@sistemadefrete.com.br",
                       password: 'password', role: :admin)
    ShippingMode.create!(name: 'Convencional', min_distance: 1, max_distance: 10000,
                        min_weight: 1, max_weight: 2000, fixed_fee: 1.00,
                        description: "Modalidade de transporte convencional")
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Taxas de acordo com peso'
    #Assert
    expect(page).to have_field('Peso mínimo')
    expect(page).to have_field('Peso máximo')
    expect(page).to have_field('Taxa')
    
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: "mari@sistemadefrete.com.br",
                       password: 'password', role: :admin)
    ShippingMode.create!(name: 'Convencional', min_distance: 1, max_distance: 10000,
                        min_weight: 1, max_weight: 2000, fixed_fee: 1.00,
                        description: "Modalidade de transporte convencional")
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Taxas de acordo com peso'
    fill_in 'Peso mínimo', with: 10
    fill_in 'Peso máximo', with: 60
    fill_in 'Taxa', with: 0.5
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Configuração salva com sucesso')
    expect(page).to have_content('10')
    expect(page).to have_content('60')
    expect(page).to have_content('0,50')
    
  end

  it 'e intervalos interceptam' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: "mari@sistemadefrete.com.br",
                       password: 'password', role: :admin)
    sm = ShippingMode.create!(name: 'Convencional', min_distance: 1, max_distance: 10000,
                        min_weight: 1, max_weight: 2000, fixed_fee: 1.00,
                        description: "Modalidade de transporte convencional")
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 10, fee_per_km: 0.25)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Taxas de acordo com peso'
    fill_in 'Peso mínimo', with: 9
    fill_in 'Peso máximo', with: 30
    fill_in 'Taxa', with: 0.45
    click_on 'Enviar'
    #Assert
  
    expect(page).to have_content('Configuração não pode ser salva')
    expect(page).not_to have_content('9')
    expect(page).not_to have_content('30')
    expect(page).not_to have_content('0,45')
    
  end

  it 'só se for administrador' do
    #Arrange
    user = User.create!(name: 'Mariana Souza', email: "mari@sistemadefrete.com.br",
                       password: 'password', role: :standard)
    sm = ShippingMode.create!(name: 'Convencional', min_distance: 1, max_distance: 10000,
                        min_weight: 1, max_weight: 2000, fixed_fee: 1.00,
                        description: "Modalidade de transporte convencional")
    sm.weight_based_fees.create!(min_weight: 0, max_weight: 10, fee_per_km: 0.25)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Taxas de acordo com peso'
    #Assert
    expect(page).not_to have_field('Peso mínimo')
    expect(page).not_to have_field('Peso máximo')
    expect(page).not_to have_field('Taxa')
    
  end
end