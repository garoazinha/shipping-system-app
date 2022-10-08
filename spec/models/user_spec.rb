require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valido?' do
    it 'e-mail deve ser do domínio @sistemadefrete.com.br' do
      #Arrange
      user = User.new(name: 'Mariana Souza', email: 'mari@email.com', password: 'pass1234')
      #Act
      result = user.valid?
      #Assert
      expect(result).to be false
    end

  end
  
end
