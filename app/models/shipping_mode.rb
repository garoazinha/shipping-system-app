class ShippingMode < ApplicationRecord

  
  has_many :vehicle_shipping_modes
  has_many :vehicles, through: :vehicle_shipping_modes
  enum status: {active: 10, inactive: 20}

  validates :name, :min_distance, :max_distance, :min_weight, :max_weight, :fixed_fee, presence: true
  validates :min_distance, :min_weight, :fixed_fee, comparison: { greater_than: 0 }
  validates :name, uniqueness: true


end
