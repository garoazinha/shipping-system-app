class WeightBasedFeesController < ApplicationController
  def index
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @shipping_mode_weight_based_fee = WeightBasedFee.new
    @weight_based_fees = @shipping_mode.weight_based_fees
  end

  def create
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    shipping_mode_weight_based_fee_params = params.require(:weight_based_fee).permit(:min_distance,
                                                                               :max_distance, :fee_per_km)
    @shipping_mode_weight_based_fee = @shipping_mode.weight_based_fees.new(shipping_mode_weight_based_fee_params)
    if @shipping_mode_weight_based_fee.save
      redirect_to shipping_mode_weight_based_fees_path(@shipping_mode.id), notice: 'Configuração salva com sucesso'
    else  
      @weight_based_fees = @shipping_mode.weight_based_fees
      flash.now[:notice] = "Configuração não pode ser salva"
      render :index
    end
  end

  def edit
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @shipping_mode_weight_based_fee = WeightBasedFee.find(params[:id])
    @weight_based_fees = @shipping_mode.weight_based_fees

  end

  def update
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    shipping_mode_weight_based_fee_params = params.require(:weight_based_fee).permit(:min_distance,
                                                                               :max_distance, :fee_per_km)
    @shipping_mode_weight_based_fee = WeightBasedFee.find(params[:id])
    if @shipping_mode_weight_based_fee.update(shipping_mode_weight_based_fee_params)
      redirect_to shipping_mode_weight_based_fees_path(@shipping_mode.id), notice: 'Configuração atualizada com sucesso'
    else  
      @weight_based_fees = @shipping_mode.weight_based_fees
      flash.now[:notice] = "Configuração não pode ser atualizada"
      render :index
    end
  end

  def disable
    @shipping_mode = ShippingMode.find(params[:shipping_mode_id])
    @weight_based_fees = @shipping_mode.weight_based_fees

    @weight_based_fees.destroy_all
    redirect_to shipping_mode_weight_based_fees_path(@shipping_mode.id)

  end
end