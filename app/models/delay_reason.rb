class DelayReason < ApplicationRecord
  belongs_to :service_order
  belongs_to :closed_delivery_datum
end
