class WeightBasedFee < ApplicationRecord
  belongs_to :shipping_mode
  validates :min_distance, :max_distance, :fee_per_km, presence: true
  validate :check_if_intervals_intersect
  validates :max_distance, comparison: { greater_than: :min_distance }
  validates :min_distance, comparison: { greater_than_or_equal_to: 0 }


  def check_if_intervals_intersect
    sm = self.shipping_mode
    sm.weight_based_fees.reload.each do |wbf|  
      if wbf.min_distance <= self.max_distance && self.min_distance <= wbf.max_distance && wbf != self 
        self.errors.add(:min_distance, 'pode estar em outro intervalo')
        self.errors.add(:max_distance, 'pode estar em outro intervalo')
      end

    end
  end
end
