class ShippingModesController < ApplicationController
  def index
    @shipping_modes = ShippingMode.all
  end

  def show
    @shipping_mode = ShippingMode.find(params[:id])
  end
  
  def new
    @shipping_mode = ShippingMode.new
  end

  def create
    
    sm_params = params.require(:shipping_mode).permit(:name, :min_distance, :max_distance, 
                                                      :min_weight, :max_weight, :description,
                                                      :fixed_fee)
    @shipping_mode = ShippingMode.new(sm_params)
    @shipping_mode.save
    redirect_to shipping_mode_path(@shipping_mode.id)

  end
  
end