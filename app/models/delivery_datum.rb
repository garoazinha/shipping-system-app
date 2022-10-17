class DeliveryDatum < ApplicationRecord
  belongs_to :shipping_mode
  belongs_to :service_order
  belongs_to :vehicle

  has_one :closed_delivery_datum

  before_validation :vehicle_becomes_busy, on: :create
  before_validation :service_order_becomes_initialized, on: :create
  
  validate :vehicle_must_be_working_for_shipping_mode


  def vehicle_becomes_busy
    self.vehicle.busy!
  end
  
  def service_order_becomes_initialized
    self.service_order.initialized!
  end

  private 

  def vehicle_must_be_working_for_shipping_mode
    if !self.shipping_mode.vehicles.include?(self.vehicle)
      self.errors.add(:vehicle, "não está em serviço")
    end
  end
  


end
