class VehicleShippingMode < ApplicationRecord
  belongs_to :vehicle
  belongs_to :shipping_mode
  validate :shipping_mode_must_not_be_available

  
  private
  def shipping_mode_must_not_be_available
    vehicle_shipping_mode_ids = self.vehicle.shipping_mode_ids
    if vehicle_shipping_mode_ids.include?(self.shipping_mode_id)
      self.errors.add(:shipping_mode_id, message: 'Modalidade de transporte já está disponível')
    end

  end
end
