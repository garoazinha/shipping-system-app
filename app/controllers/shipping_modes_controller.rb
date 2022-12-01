class ShippingModesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :deactivate]
  before_action :check_user_role, only: [:new, :create, :edit, :update, :deactivate]
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
    if @shipping_mode.save
      redirect_to shipping_mode_path(@shipping_mode.id), notice: "Modalidade de transporte salva com sucesso"
    else
      flash.now[:alert] = "Cadastro de modalidade de transporte não pode ser realizada"
      render :new
    end

  end

  def edit
    @shipping_mode = ShippingMode.find(params[:id])
  end

  def update
    @shipping_mode = ShippingMode.find(params[:id])
    sm_params = params.require(:shipping_mode).permit(:name, :min_distance, :max_distance, 
                                                      :min_weight, :max_weight, :description,
                                                      :fixed_fee, :status)
    if @shipping_mode.update(sm_params)
      redirect_to @shipping_mode, notice: 'Modalidade de transporte atualizada com sucesso'
    else
      flash.now[:alert] = "Modalidade de transporte não pode ser atualizada"
      render :edit
    end
  end

  def deactivate
    @shipping_mode = ShippingMode.find(params[:id])
    @shipping_mode.inactive!

    redirect_to shipping_modes_path, notice: 'Modalidade de transporte desativada com sucesso'

  end
  
  private

  def shipping_mode_params
  end

  
  
end