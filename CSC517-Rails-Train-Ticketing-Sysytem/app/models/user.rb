class User < ApplicationRecord
    has_secure_password
    has_many :bookings
    has_many :reviews
    validates :email_address, presence: true, uniqueness: true
    validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP,  message: "is invalid" }
    validates :name, :address, :phone_number, :credit_number, presence: true
    validates :phone_number, :credit_number, format: { with: /\A[\d\-]+\z/, message: "should contain only numbers" }
    def admin?
      admin
    end
end
  