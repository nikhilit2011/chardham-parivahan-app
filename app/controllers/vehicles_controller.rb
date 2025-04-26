# app/controllers/vehicles_controller.rb

class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: %i[show edit update]

  def index
    @vehicles = Vehicle.order(created_at: :desc).page(params[:page]).per(1)
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: "Vehicle was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: "Vehicle was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def search
    # Search form page (no logic here yet)
  end

  def results
    @vehicles = Vehicle.all

    if params[:dham_destinations].present?
      selected_dhams = Array(params[:dham_destinations]).map(&:strip)
      @vehicles = @vehicles.select { |v| (v.dham_list & selected_dhams).any? }
    end

    if params[:vehicle_number].present?
      formatted_number = format_vehicle(params[:vehicle_number])
      @vehicles = @vehicles.where("vehicle_number ILIKE ?", "%#{formatted_number}%")
    end

    @vehicles = @vehicles.where(check_date: params[:check_date]) if params[:check_date].present?
    @vehicles = @vehicles.where("owner ILIKE ?", "%#{params[:owner]}%") if params[:owner].present?
    @vehicles = @vehicles.where("checkpost ILIKE ?", "%#{params[:checkpost]}%") if params[:checkpost].present?
    @vehicles = @vehicles.where("char_dham_registration_number ILIKE ?", "%#{params[:char_dham_registration_number]}%") if params[:char_dham_registration_number].present?
    @vehicles = @vehicles.where(green_card_status: params[:green_card_status]) if params[:green_card_status].present?
    @vehicles = @vehicles.where(trip_card_status: params[:trip_card_status]) if params[:trip_card_status].present?
    @vehicles = @vehicles.where(number_of_pilgrims: params[:number_of_pilgrims]) if params[:number_of_pilgrims].present?

    if params[:registered_in_uttarakhand].present?
      value = ActiveModel::Type::Boolean.new.cast(params[:registered_in_uttarakhand])
      @vehicles = @vehicles.where(registered_in_uttarakhand: value)
    end

    @vehicles = @vehicles.where("remarks ILIKE ?", "%#{params[:remarks]}%") if params[:remarks].present?

    # Pagination
    @vehicles = @vehicles.page(params[:page]).per(50)
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(
      :vehicle_number, :checkpost, :owner, :char_dham_registration_number,
      :green_card_status, :trip_card_status, :check_date, :number_of_pilgrims,
      :return_date, :registered_in_uttarakhand, :remarks,
      dham_destinations: []
    )
  end

  def format_vehicle(raw)
    return raw if raw.blank?

    raw = raw.gsub(/\s+/, "").upcase
    if raw =~ /\A([A-Z]{2})(\d{2})([A-Z]{1,3})(\d{4})\z/
      "#{$1} #{$2} #{$3} #{$4}"
    else
      raw
    end
  end
end
