class DistanceBasedFeesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :edit, :update]
  before_action :check_user_role, only: [:create, :edit]
  def index
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @shipping_mode_distance_based_fee = DistanceBasedFee.new
    @distance_based_fees = @shipping_mode.distance_based_fees.reload
  end

  def create
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    shipping_mode_distance_based_fee_params = params.require(:distance_based_fee).permit(:min_distance,
                                                                                 :max_distance, :fee)
    @shipping_mode_distance_based_fee = @shipping_mode.distance_based_fees.new(shipping_mode_distance_based_fee_params)
    if @shipping_mode_distance_based_fee.save
      redirect_to shipping_mode_distance_based_fees_path(@shipping_mode.id), notice: 'Nova configuração de preço salva com sucesso'
    else 
      @distance_based_fees = @shipping_mode.distance_based_fees.reload
      flash.now[:notice] = "Configuração não pode ser salva"
      render :index
    end
  end

  def edit
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @shipping_mode_distance_based_fee = DistanceBasedFee.find(params[:id])
    @distance_based_fees = @shipping_mode.distance_based_fees.reload

  end

  def update
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @shipping_mode_distance_based_fee = DistanceBasedFee.find(params[:id])
    
    shipping_mode_distance_based_fee_params = params.require(:distance_based_fee).permit(:min_distance,
                                                                                  :max_distance, :fee)
    if @shipping_mode_distance_based_fee.update(shipping_mode_distance_based_fee_params)
      redirect_to shipping_mode_distance_based_fees_path(@shipping_mode.id), notice: 'Taxa atualizada com sucesso'
    else 
      @distance_based_fees = @shipping_mode.distance_based_fees.reload
      flash.now[:notice] = "Taxa não pode ser atualizada"
      render :edit
    end

  end

  def disable
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @shipping_mode.distance_based_fees.destroy_all
    redirect_to shipping_mode_distance_based_fees_path(@shipping_mode.id)

  end

end