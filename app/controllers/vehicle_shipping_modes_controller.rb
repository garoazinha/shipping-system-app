class VehicleShippingModesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :check_user_role, only: [:new, :create, :destroy]
  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @vehicle_shipping_mode = VehicleShippingMode.new
    @shipping_modes = ShippingMode.all
  end

  def create
    @vehicle = Vehicle.find(params[:vehicle_id])
    vehicle_shipping_mode_params = params.require(:vehicle_shipping_mode).permit(:shipping_mode_id)
    @vehicle_shipping_mode = @vehicle.vehicle_shipping_modes.new(vehicle_shipping_mode_params)
    if @vehicle_shipping_mode.save
      redirect_to @vehicle, notice: 'Modalidade de transporte associada com sucesso'
    else
      @shipping_modes = ShippingMode.all
      render :new
    end

    
  end

  def destroy
    @vehicle = Vehicle.find(params[:vehicle_id])
    @vehicle_shipping_mode = VehicleShippingMode.find(params[:id])
    @vehicle_shipping_mode.destroy
    redirect_to @vehicle, notice: 'Modalidade de transporte desabilitada com sucesso'
  end
end