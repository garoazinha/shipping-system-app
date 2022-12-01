class DeliveryTimesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_role, only: [:create, :edit, :update]

  def index
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @delivery_times = @shipping_mode.delivery_times.reload
    @shipping_mode_delivery_time = DeliveryTime.new
  end

  def create
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    shipping_mode_delivery_time_params = params.require(:delivery_time).permit(:min_distance,
                                                                 :max_distance,:estimated_delivery_time)
    @shipping_mode_delivery_time = @shipping_mode.delivery_times.new(shipping_mode_delivery_time_params) 
                                                             
    if @shipping_mode_delivery_time.save
      redirect_to shipping_mode_delivery_times_path(@shipping_mode.id), notice: 'Nova configuração salva com sucesso'
    else 
      flash.now[:alert] = 'Não foi possível configurar prazo'
      @delivery_times = @shipping_mode.delivery_times.reload

      render :index
    end

  end

  def edit
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @shipping_mode_delivery_time = DeliveryTime.find(params[:id])
    @delivery_times = @shipping_mode.delivery_times.reload

  end

  def update
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    shipping_mode_delivery_time_params = params.require(:delivery_time).permit(:estimated_delivery_time)
    @shipping_mode_delivery_time = DeliveryTime.find(params[:id]) 
                                                             
    if @shipping_mode_delivery_time.update(shipping_mode_delivery_time_params)
      redirect_to shipping_mode_delivery_times_path(@shipping_mode.id), notice: 'Configuração atualizada com sucesso'
    else 
      flash.now[:alert] = 'Não foi possível configurar prazo'
      @delivery_times = @shipping_mode.delivery_times.reload
      render :edit
    end
  end

  def disable
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @delivery_times = @shipping_mode.delivery_times
    @delivery_times.destroy_all

    redirect_to shipping_mode_delivery_times_path(@shipping_mode.id), notice: "Prazos desabilitados"
    
  end
  
end