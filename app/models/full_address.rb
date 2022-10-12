class FullAddress < ApplicationRecord
  belongs_to :service_order
  enum belonging_to: { shipper: 5 , recipient: 8 }
  validates :city, :state, :zip_code, :address, presence: true
  validates :zip_code, format: { with: /[0-9]{9}/}
end
