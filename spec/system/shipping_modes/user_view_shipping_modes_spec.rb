require 'rails_helper'

describe 'Usuário vê modalidades de transporte' do
  it 'a partir da tela inicial' do
    #Arrange
    ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
                         min_weight: 1, max_weight: 10000, fixed_fee: 1)
    ShippingMode.create!(name: 'Convencional', min_distance: 1, max_distance: 3000,
                          min_weight: 1, max_weight: 100000, fixed_fee: 0.5)
    #Act
    visit root_path
    click_on 'Modalidades de transporte'

    #Assert
    expect(page).to have_content('Express')
    expect(page).to have_content('Intervalo de distância: 1-1000 km')
    expect(page).to have_content('Intervalo de peso: 0,001-10 kg')
    expect(page).to have_content('Taxa fixa: R$1,00')
    expect(page).to have_content('Convencional')
    expect(page).to have_content('Intervalo de distância: 1-3000 km')
    expect(page).to have_content('Intervalo de peso: 0,001-100 kg')
    expect(page).to have_content('Taxa fixa: R$0,50')
    
  end

  it 'e não há modalidades de transporte cadastradas' do
    #Arrange
    #Act
    visit root_path
    click_on 'Modalidades de transporte'

    #Assert
    expect(page).to have_content("Não há modalidades de transporte disponíveis")
  end

  it 'e vê detalhes da modalidade' do
    #Arrange
    ShippingMode.create!(name: 'Express', min_distance: 1, max_distance: 1000,
      min_weight: 1, max_weight: 10000, fixed_fee: 1)
    ShippingMode.create!(name: 'Convencional', min_distance: 1, max_distance: 3000,
          min_weight: 1, max_weight: 100000, fixed_fee: 0.5)
    #Act
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'

    #Assert
   
    expect(page).to have_content('Convencional')
    expect(page).to have_content('Intervalo de distância de serviço: 1-3000 km')
    expect(page).to have_content('Intervalo de peso de serviço: 0,001-100 kg')
    expect(page).to have_content('Taxa fixa: R$0,50')
    expect(page).to have_content('Status: Ativo')
    
  end
end