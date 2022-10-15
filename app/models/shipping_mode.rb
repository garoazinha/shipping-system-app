class ShippingMode < ApplicationRecord

  has_many :delivery_times
  has_many :distance_based_fees
  has_many :weight_based_fees
  has_many :vehicle_shipping_modes
  has_many :vehicles, through: :vehicle_shipping_modes
  has_many :delivery_data
  has_many :service_orders, through: :delivery_data
  enum status: {active: 10, inactive: 20}

  validates :name, :min_distance, :max_distance, :min_weight, :max_weight, :fixed_fee, presence: true
  validates :min_distance, :min_weight, :fixed_fee, comparison: { greater_than_or_equal_to: 0 }
  validates :fixed_fee, comparison: { greater_than: 0 }
  validates :name, uniqueness: true
  

  def find_estimated_delivery_time(distance: )
    sm_delivery_time = self.delivery_times.where(min_distance: ..distance).find_by(max_distance: distance..)
    sm_delivery_time.estimated_delivery_time
  end

  def find_weight_based_fee(product_weight: )
    sm_weight_based_fee = self.weight_based_fees.where(min_weight: ..product_weight).find_by(max_weight: product_weight..)
    sm_weight_based_fee.fee_per_km
  end

  def find_distance_based_fee(distance: )
    sm_distance_based_fee = self.distance_based_fees.where(min_distance: ..distance).find_by(max_distance: distance..)
    sm_distance_based_fee.fee
  end

  def total_price(distance:, product_weight:)
    find_distance_based_fee(distance: distance ) + find_weight_based_fee(product_weight: product_weight )*distance + self.fixed_fee
  end

end
