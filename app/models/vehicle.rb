class Vehicle < ApplicationRecord
  has_many :vehicle_shipping_modes
  has_many :shipping_modes, through: :vehicle_shipping_modes
  
  validates :plate_number, :brand, :model, :year, :max_capacity, presence: true
  validates :year, comparison: { greater_than: 1980 }
  validates :year, comparison: { less_than_or_equal_to: Date.today.year }
  validates :plate_number, format: { with: /\A[a-zA-Z]{3}[0-9]{4}\z|\A[a-zA-Z]{3}[0-9][a-zA-Z][0-9]{2}\z/}
  validates :plate_number, uniqueness: true
  enum activity: { operational: 5, maintenance: 9 }


end
