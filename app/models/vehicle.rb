class Vehicle < ApplicationRecord
  before_validation :normalize_vehicle_number
  before_validation :join_dham_destinations

  validates :vehicle_number, :check_date, :checkpost, :owner,
            :char_dham_registration_number, :green_card_status,
            :trip_card_status, :number_of_pilgrims,
            presence: true

  validate :validate_dham_destinations_presence
  validate :return_date_not_equal_check_date
  validate :require_return_date_if_duplicate_vehicle_on_diff_date, on: :create
  validate :prevent_return_date_on_create, on: :create

  validates :vehicle_number, uniqueness: { scope: :check_date }

  VALID_VEHICLE_REGEX = /\A[A-Z]{2} \d{2} [A-Z]{1,3} \d{4}\z/
  validates :vehicle_number, format: {
    with: VALID_VEHICLE_REGEX,
    message: "must be in format: UK 07 TA 1234"
  }

  def dham_list
    dham_destinations&.split(',')&.map(&:strip) || []
  end

  private

  def join_dham_destinations
    if dham_destinations.is_a?(Array)
      self.dham_destinations = dham_destinations.reject(&:blank?).join(",")
    end
  end

  def normalize_vehicle_number
    return if vehicle_number.blank?

    raw = vehicle_number.gsub(/\s+/, "").upcase
    if raw =~ /\A([A-Z]{2})(\d{2})([A-Z]{1,3})(\d{4})\z/
      self.vehicle_number = "#{$1} #{$2} #{$3} #{$4}"
    end
  end

  def validate_dham_destinations_presence
    if dham_destinations.blank? || dham_destinations.strip.empty?
      errors.add(:dham_destinations, "can't be blank")
    end
  end

  def return_date_not_equal_check_date
    return if return_date.blank?
    if return_date == check_date
      errors.add(:return_date, "cannot be the same as check date")
    end
  end

  def require_return_date_if_duplicate_vehicle_on_diff_date
    existing_vehicle = Vehicle.where(vehicle_number: vehicle_number)
                              .where.not(check_date: check_date)
                              .exists?

    if existing_vehicle && return_date.blank?
      errors.add(:return_date, "must be filled if this vehicle has a record on a different date")
    end
  end

  def prevent_return_date_on_create
    if return_date.present?
      errors.add(:return_date, "can only be filled while editing")
    end
  end
end
