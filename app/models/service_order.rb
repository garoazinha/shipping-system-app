class ServiceOrder < ApplicationRecord
  has_one :delivery_datum
  has_one :shipping_mode, through: :delivery_datum
  has_one :closed_delivery_datum
  has_one :delay_reason, through: :closed_delivery_datum
  has_many :full_addresses
  accepts_nested_attributes_for :full_addresses

  enum status: {pending: 4, initialized: 6, closed: 9}

  before_validation :generate_code, on: :create
  
  validates :product_code, :recipient_name, :recipient_registration_number, :distance, presence: true
  validates :distance, comparison: { greater_than: 0 }
  validates :full_addresses, length: { is: 2 }
  validates_associated :full_addresses
  
  validate :check_if_one_recipient_one_shipper


  def late?
    if !self.pending?
      if Time.now > self.delivery_datum.end_date
        return true
      else
        return false
      end
    end
  end




  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

 

  def check_if_one_recipient_one_shipper
    if self.full_addresses.first.recipient? && self.full_addresses.last.recipient?
      self.errors.add :base, :invalid, message: "Ordem de serviço deve ter destinatário e recipiente"
    elsif self.full_addresses.first.shipper? && self.full_addresses.last.shipper?
      self.errors.add :base, :invalid, message: "Ordem de serviço deve ter destinatário e recipiente"

    end
  end

end