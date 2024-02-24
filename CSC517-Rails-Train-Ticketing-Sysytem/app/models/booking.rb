class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :train

  before_create :generate_booking_code

  private

  def generate_booking_code
    self.booking_code = SecureRandom.random_number(1_000_000_000).to_s.rjust(9, '0')
  end
end
