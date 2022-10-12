class DeliveryTime < ApplicationRecord
  belongs_to :shipping_mode
  validates :max_distance, :min_distance, :estimated_delivery_time, presence: true
  validate :check_if_intervals_intersect, on: :create
  validates :max_distance, comparison: { greater_than: :min_distance }

  validate :check_uniqueness_of_estimated_delivery_time

  private
  def check_uniqueness_of_estimated_delivery_time
    sm = self.shipping_mode
    sm.delivery_times.reload.each do |dt|  
      if dt.estimated_delivery_time == self.estimated_delivery_time
        self.errors.add(:estimated_delivery_time, 'já está em uso')

      end
    end
  end
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
