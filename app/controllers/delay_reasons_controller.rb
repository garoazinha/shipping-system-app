class DelayReasonsController < ApplicationController
  before_action :authenticate_user!

  def new
    @service_order = ServiceOrder.find(params[:service_order_id])
    @delay_reason = DelayReason.new
  end

  def create
    @service_order = ServiceOrder.find(params[:service_order_id])
    reason_for_delay = params[:delay_reason][:reason_for_delay]
    closed_delivery_datum = @service_order.closed_delivery_datum
    @delay_reason = closed_delivery_datum.build_delay_reason(service_order: @service_order,
                                                         reason_for_delay: reason_for_delay)
    @delay_reason.save
    redirect_to @service_order, notice: "Motivo de atraso salvo!"
  
  end
end