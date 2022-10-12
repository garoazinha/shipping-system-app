class ServiceOrder < ApplicationRecord
  validates :product_code, :recipient_name, :recipient_registration_number, :distance, presence: true
  validates :distance, comparison: { greater_than: 0 }
  has_many :full_addresses
  accepts_nested_attributes_for :full_addresses
  enum status: {pending: 4, initiated: 6, ended: 9}
  before_validation :generate_code, on: :create
  validates_associated :full_addresses
  validate :check_addresses_presence
  validate :check_if_one_recipient_one_shipper
  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def check_addresses_presence
    if self.full_addresses.size != 2
      self.errors.add :base, :invalid, message: "Ordem de serviço deve ter dois endereços"
    end
  end

  def check_if_one_recipient_one_shipper
    if self.full_addresses.first.recipient? && self.full_addresses.last.recipient?
      self.errors.add :base, :invalid, message: "Ordem de serviço deve ter destinatário e recipiente"
    elsif self.full_addresses.first.shipper? && self.full_addresses.last.shipper?
      self.errors.add :base, :invalid, message: "Ordem de serviço deve ter destinatário e recipiente"

    end
  end

end