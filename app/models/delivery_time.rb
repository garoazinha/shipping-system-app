class DeliveryTime < ApplicationRecord
  belongs_to :shipping_mode
  validates :max_distance, :min_distance, :estimated_delivery_time, presence: true
  validates :min_distance, comparison: { greater_than_or_equal_to: 0 }
  validate :check_if_intervals_intersect
  validates :max_distance, comparison: { greater_than: :min_distance }
  validates :estimated_delivery_time, uniqueness: true

  private

  def check_if_intervals_intersect
    sm = self.shipping_mode
    sm.delivery_times.reload.each do |dt|  
      if dt.min_distance <= self.max_distance && self.min_distance <= dt.max_distance && dt != self 
        self.errors.add(:min_distance, 'pode estar em outro intervalo')
        self.errors.add(:max_distance, 'pode estar em outro intervalo')
      end

    end
  end
end
