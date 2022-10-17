class DeliveriesController < ApplicationController
  
  def lookup
    @delivery_code = params[:delivery_code]
    @service_order = ServiceOrder.where(status: :initialized).or(ServiceOrder.where(status: :closed)).find_by(code: @delivery_code)
  end

end