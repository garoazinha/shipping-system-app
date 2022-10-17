class ClosedDeliveryDatum < ApplicationRecord
  belongs_to :service_order
  belongs_to :delivery_datum
  has_one :delay_reason
  enum status: {on_time: 3, late: 5}

  before_validation :close_service_order, on: :create
  before_validation :get_end_date, on: :create
  after_create :change_status_if_late
  after_create :vehicle_becomes_operational

  private 

  def vehicle_becomes_operational
    self.delivery_datum.vehicle.operational!
  end
  
  def get_end_date
    self.estimated_end_date = self.delivery_datum.end_date
  end

  def change_status_if_late
    if self.estimated_end_date < self.closing_date
      self.late!
    end
  end

  def close_service_order
    self.service_order.closed!
  end
  
 
end
