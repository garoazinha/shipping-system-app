require 'rails_helper'

describe 'Usuário cadastra nova modalidade de transporte' do
  it 'com sucesso' do
    #Arrange

    #Act
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Cadastrar nova modalidade de transporte'
    fill_in 'Nome', with: 'EXP12'
    fill_in 'Distância mínima de serviço', with: '1'
    fill_in 'Distância máxima de serviço', with: '200'
    fill_in 'Peso mínimo de serviço', with: '1'
    fill_in 'Peso máximo de serviço', with: '100000'
    fill_in 'Taxa fixa', with: '1.25'
    fill_in 'Descrição', with: 'Modalidade de transporte que permite entrega em até 12 horas'
    click_on 'Enviar'


    #Assert
    expect(page).to have_content("Modalidade de transporte salva com sucesso")
    expect(page).to have_content('EXP12')
    expect(page).to have_content('Intervalo de distância de serviço: 1-200 km')
    expect(page).to have_content('Intervalo de peso de serviço: 0,001-100 kg')
    expect(page).to have_content('Taxa fixa: R$1,25')
    expect(page).to have_content("Modalidade de transporte que permite entrega em até 12 horas")
  end

  it 'e não preenche os campos obrigatórios' do
    #Arrange

    #Act
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Cadastrar nova modalidade de transporte'
    fill_in 'Nome', with: ''
    fill_in 'Distância mínima de serviço', with: '1'
    fill_in 'Distância máxima de serviço', with: '200'
    fill_in 'Taxa fixa', with: ''
    fill_in 'Descrição', with: 'Modalidade de transporte que permite entrega em até 12 horas'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content("Cadastro de modalidade de transporte não pode ser realizada")
    expect(page).to have_content("Nome não pode ficar em branco")
    expect(page).to have_content("Taxa fixa não pode ficar em branco")
    expect(page).to have_content("Peso mínimo de serviço não pode ficar em branco")
    expect(page).to have_content("Peso máximo de serviço não pode ficar em branco")
    
  end
end