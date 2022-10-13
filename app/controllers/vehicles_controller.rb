class VehiclesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :index]
  before_action :check_user_role, only: [:new, :create, :edit, :update]
  def index
    @vehicles =  Vehicle.all
    
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    vehicle_params = params.require(:vehicle).permit(:plate_number, :model, :brand,
                                                     :year, :max_capacity, :activity)
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: 'Veículo salvo com sucesso'
    else
      flash.now[:notice] = 'Veículo não pode ser salvo'
      render :new

    end

  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    vehicle_params = params.require(:vehicle).permit(:plate_number, :model, :brand,
                                                    :year, :max_capacity, :activity)
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: 'Veículo atualizado com sucesso'
    else
      flash.now[:notice] = 'Veículo não pode ser atualizado'
      render :edit

    end
  end

  def search
    @query = params[:query]
    @vehicles = Vehicle.where("plate_number LIKE ?", "%#{@query}%")
  end
  


end