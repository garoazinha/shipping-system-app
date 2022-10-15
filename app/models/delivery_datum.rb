class DeliveryDatum < ApplicationRecord
  belongs_to :shipping_mode
  belongs_to :service_order
  belongs_to :vehicle

  after_validation :vehicle_becomes_busy
  after_validation :service_order_becomes_initialized
  


  def vehicle_becomes_busy
    self.vehicle.busy!
  end
  
  def service_order_becomes_initialized
    self.service_order.initialized!
  end

  private 
  


end
