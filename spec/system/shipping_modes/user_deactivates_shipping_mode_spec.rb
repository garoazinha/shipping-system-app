require 'rails_helper'

describe 'Usuário desativa modalidade de transporte' do
  it 'na página de edição' do
    #Arrange
    sm = ShippingMode.create(name: 'Convencional', min_weight: 1, max_weight: 100000,
                            min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                            description: "Modalidade de transporte convencional")
    #Act
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Editar'
    
    #Assert
    expect(page).to have_button('Desativar')

  end

  it 'com sucesso' do
    #Arrange
    sm = ShippingMode.create(name: 'Convencional', min_weight: 1, max_weight: 100000,
                            min_distance: 1, max_distance: 2000, fixed_fee: 1.00,
                            description: "Modalidade de transporte convencional")
    sm = ShippingMode.create(name: 'EXP12', min_weight: 1, max_weight: 10000,
                            min_distance: 1, max_distance: 500, fixed_fee: 1.50,
                            description: "Modalidade de transporte expresso até 12 horas")
    #Act
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Convencional'
    click_on 'Editar'
    click_on 'Desativar'
    #Assert
    expect(page).to have_content('Modalidade de transporte desativada com sucesso')
    expect(current_path).to eq(shipping_modes_path)
    expect(page).not_to have_content('Convencional')
    expect(page).to have_content('EXP12')
        
  end
end