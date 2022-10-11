class DeliveryTime < ApplicationRecord
  belongs_to :shipping_mode
  validate :check_if_intervals_intersect, on: :create
  validates :max_distance, comparison: { greater_than: :min_distance }
  #validates :estimated_delivery_time, uniqueness: { scope: :status }, on: :create
  enum status: { active: 2, inactive: 9 }
  validate :check_uniqueness_in_update

  private
  def check_uniqueness_in_update 
    sm = self.shipping_mode
    sm.delivery_times.active.reload.each do |dt|  
      if self.active? && dt.estimated_delivery_time == self.estimated_delivery_time
        self.errors.add(:estimated_delivery_time, 'já está em uso')

      end
    end
  end
  def check_if_intervals_intersect
    sm = self.shipping_mode
    sm.delivery_times.active.reload.each do |dt|  
      if dt.min_distance <= self.max_distance && self.min_distance <= dt.max_distance && dt != self 
        self.errors.add(:min_distance, 'pode estar em outro intervalo')
        self.errors.add(:max_distance, 'pode estar em outro intervalo')
      end

    end
  end
end
