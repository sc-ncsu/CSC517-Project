class BookingsController < ApplicationController

  def show
  end

  def search
    load_bookings
    @bookings = @bookings.joins(:user, :train)
    @bookings = @bookings.where("lower(trains.number) LIKE ?", "%#{params[:train_q].downcase}%") if params[:train_q].present?
    render :index
  end

  def index
    load_bookings
  end

  private

  def load_bookings
    if current_user && current_user.admin?
      @bookings = Booking.all
    else
      @bookings = current_user.bookings
    end
  end
end
