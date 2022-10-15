class WeightBasedFee < ApplicationRecord
  belongs_to :shipping_mode
  validates :min_weight, :max_weight, :fee_per_km, presence: true
  validate :check_if_intervals_intersect
  validates :max_weight, comparison: { greater_than: :min_weight }
  validates :min_weight, comparison: { greater_than_or_equal_to: 0 }


  def check_if_intervals_intersect
    sm = self.shipping_mode
    sm.weight_based_fees.reload.each do |wbf|  
      if wbf.min_weight <= self.max_weight && self.min_weight <= wbf.max_weight && wbf != self 
        self.errors.add(:min_weight, 'pode estar em outro intervalo')
        self.errors.add(:max_weight, 'pode estar em outro intervalo')
      end

    end
  end
end
