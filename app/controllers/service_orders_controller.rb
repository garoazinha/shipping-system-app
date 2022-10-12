class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_role, only: [:new, :create]

  def show
    @service_order = ServiceOrder.find(params[:id])
  end
  def index
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

end