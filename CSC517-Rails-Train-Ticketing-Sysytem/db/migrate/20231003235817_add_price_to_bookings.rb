class AddPriceToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :price, :decimal
  end
end
