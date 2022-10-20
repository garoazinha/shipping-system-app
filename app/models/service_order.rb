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

  def find_available_shipping_modes
    distance = self.distance
    product_weight = self.product_weight
    ShippingMode.where(min_distance: ..distance).where(max_distance: distance..).where(min_weight: ..product_weight).where(max_weight: product_weight..)
  end

  def build_delivery_data(shipping_mode:)
    vehicle = shipping_mode.vehicles.operational.first
    estimated_delivery_time = shipping_mode.find_estimated_delivery_time(
                                        distance: self.distance)
    total_price = shipping_mode.total_price(distance: self.distance,
                               product_weight: self.product_weight )
    DeliveryDatum.new(service_order: self, shipping_mode: shipping_mode, vehicle: vehicle, 
                      estimated_delivery_time: estimated_delivery_time,
                      total_price: total_price,
                      creation_date: Time.now, end_date: Time.now + estimated_delivery_time.hours)

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