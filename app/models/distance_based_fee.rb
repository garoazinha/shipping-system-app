class DistanceBasedFee < ApplicationRecord
  belongs_to :shipping_mode
  validate :check_if_intervals_intersect
  validates :min_distance, :max_distance, :fee, presence: true
  validates :min_distance, comparison: { greater_than_or_equal_to: 0 }
  validates :fee, comparison: { greater_than: 0 }
  validates :max_distance, comparison: { greater_than: :min_distance }
  
  def check_if_intervals_intersect
    sm = self.shipping_mode
    sm.distance_based_fees.reload.each do |dbf|  
      if dbf.min_distance <= self.max_distance && self.min_distance <= dbf.max_distance && dbf != self 
        self.errors.add(:min_distance, 'pode estar em outro intervalo')
        self.errors.add(:max_distance, 'pode estar em outro intervalo')
      end

    end
  end
end
