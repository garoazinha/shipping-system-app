class ClosedDeliveryDatum < ApplicationRecord
  belongs_to :service_order
  enum status: {on_time: 3, late: 5}

end
