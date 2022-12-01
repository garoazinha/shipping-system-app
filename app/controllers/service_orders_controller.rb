class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_role, only: [:new, :create]

  def show
    @service_order = ServiceOrder.find(params[:id])
    @shipping_modes = @service_order.find_available_shipping_modes
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
      flash.now[:alert] = 'Ordem de serviço não pode ser criada'
      render :new
    end



  end

  def initialize_delivery_of
    @shipping_mode = ShippingMode.find(params[:delivery_datum][:shipping_mode_id])
    @service_order = ServiceOrder.find(params[:id])
    @delivery_datum = @service_order.build_delivery_data(shipping_mode: @shipping_mode)
    if @delivery_datum.save

      redirect_to @service_order, notice: "Ordem de serviço iniciada com sucesso" 
    
    end
  end

  def close_delivery_of
    @service_order = ServiceOrder.find(params[:id])
    delivery_datum = @service_order.delivery_datum
    closed_delivery_datum = @service_order.create_closed_delivery_datum(closing_date: Time.now, delivery_datum: delivery_datum)
    if closed_delivery_datum.late?
      redirect_to new_service_order_delay_reason_path(@service_order.id), notice: "Ordem de serviço terminada com atraso"
    else
      redirect_to @service_order, notice: "Ordem de serviço terminada no prazo"
    end
  end

  def closed
    @service_orders = ServiceOrder.closed
  end


  private



end