class Train < ApplicationRecord
    has_many :bookings, dependent: :destroy
    has_many :reviews, dependent: :destroy

    validates :number, :departure_station, :termination_station, :departure_date, :departure_time,
    :arrival_date, :arrival_time, :ticket_price, :train_capacity, :seats_left,
    presence: true
    validates :train_capacity, numericality: { greater_than_or_equal_to: 0, message: "should be a valid value" }
    validates :seats_left, numericality: { greater_than_or_equal_to: 0, message: "should be a non-negative number" }
    validates :seats_left, numericality: { less_than_or_equal_to: ->(train) { train.train_capacity }, message: "Seats left should be less than capacity" }
    validates :ticket_price, numericality: { greater_than_or_equal_to: 0, message: "should be a non-negative number" }
    validate :validate_departure_and_arrival

    private

    def validate_departure_and_arrival
      return unless departure_date && departure_time && arrival_date && arrival_time
  
      if departure_date > arrival_date || (departure_date == arrival_date && departure_time >= arrival_time)
        errors.add(:departure_date, "and time should be less than arrival date and time")
      end
    end
end
