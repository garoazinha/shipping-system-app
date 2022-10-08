class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { standard: 2, admin: 5 } 

  validates :email, format: { with: /\A[\w]{1,15}@sistemadefrete.com.br\z/, message: 'deve ser do domínio @sistemadefrete.com.br'}
end
