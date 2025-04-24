class Vehicle < ApplicationRecord
  # Normalize and join dham destinations before validations
  before_validation :normalize_vehicle_number
  before_validation :join_dham_destinations

  validates :vehicle_number, :check_date, :checkpost, :owner,
            :char_dham_registration_number, :green_card_status,
            :trip_card_status, :number_of_pilgrims,
            :registered_in_uttarakhand,
            presence: true

  validate :validate_dham_destinations_presence

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
end
