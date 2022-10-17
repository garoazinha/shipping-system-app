class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_role, only: [:new, :create]

  def show
    @service_order = ServiceOrder.find(params[:id])
    @shipping_modes = find_available_shipping_modes
    @delivery_datum = DeliveryDatum.new

  end

  def index
    @service_orders = ServiceOrder.all
  end

  def new
    @service_order = ServiceOrder.new

    @service_order.full_addresses.build()

  end

  def create
    service_order_params = params.require(:service_order).permit(:product_code, :product_width,
                           :product_height, :product_depth, :product_weight,
                           :recipient_name, :recipient_registration_number, :distance,
                           full_addresses_attributes: [:id, :belonging_to, :city, :state, :zip_code, :address])
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save
      redirect_to service_order_path(@service_order.id), notice: 'Ordem de serviço criada com sucesso'
    else

      @service_order.full_addresses.build()
      flash.now[:notice] = 'Ordem de serviço não pode ser criada'
      render :new
    end



  end

  def initialize_delivery_of
    
    @delivery_datum = build_delivery_data
    if @delivery_datum.save

      redirect_to @service_order, notice: "Ordem de serviço iniciada com sucesso" 
    
    end
  end

  def close_delivery_of
    @service_order = ServiceOrder.find(params[:id])
    delivery_datum = @service_order.delivery_datum
    closed_delivery_datum = @service_order.create_closed_delivery_datum(closing_date: Time.now, delivery_datum: delivery_datum)
    if @service_order.late?
      redirect_to new_service_order_delay_reason_path(@service_order.id), notice: "Ordem de serviço terminada com atraso"
    else
      redirect_to @service_order, notice: "Ordem de serviço terminada no prazo"
    end
  end



  private

  def find_available_shipping_modes
    @service_order = ServiceOrder.find(params[:id])
    distance = @service_order.distance
    product_weight = @service_order.product_weight
    ShippingMode.where(min_distance: ..distance).where(max_distance: distance..).where(min_weight: ..product_weight).where(max_weight: product_weight..)
  end

  def build_delivery_data
    @service_order = ServiceOrder.find(params[:id])
    @shipping_mode = ShippingMode.find(params[:delivery_datum][:shipping_mode_id])
    @vehicle = @shipping_mode.vehicles.operational.first
    estimated_delivery_time = @shipping_mode.find_estimated_delivery_time(
                                        distance: @service_order.distance)
    total_price = @shipping_mode.total_price(distance: @service_order.distance,
                               product_weight: @service_order.product_weight )
    DeliveryDatum.new(service_order: @service_order, shipping_mode: @shipping_mode, vehicle: @vehicle, 
                                estimated_delivery_time: estimated_delivery_time,
                                total_price: total_price,
                                creation_date: Time.now, end_date: Time.now + estimated_delivery_time.hours)

  end




end