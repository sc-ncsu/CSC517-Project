# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
departure_time = Time.now + 1.month
Train.create(
    number: 'ABC123',
    departure_station: 'Station A',
    termination_station: 'Station B',
    departure_date: Date.today,
    departure_time: Time.now,
    arrival_date: Date.tomorrow,
    arrival_time: Time.now + 1.hour,
    ticket_price: 50.0,
    train_capacity: 100,
    seats_left: 100
  )

  Train.create(
    number: 'DEF456',
    departure_station: 'Station C',
    termination_station: 'Station D',
    departure_date: Date.today,
    departure_time: Time.now,
    arrival_date: Date.tomorrow,
    arrival_time: Time.now + 1.hour,
    ticket_price: 60.0,
    train_capacity: 120,
    seats_left: 120
  )

  Train.create(
    number: 'DEF489',
    departure_station: 'Station C',
    termination_station: 'Station D',
    departure_date: Date.today,
    departure_time: Time.now,
    arrival_date: Date.tomorrow,
    arrival_time: Time.now + 1.hour,
    ticket_price: 60.0,
    train_capacity: 120,
    seats_left: 120
  )

  Train.create(
    number: 'ABC123',
    departure_station: 'Station A',
    termination_station: 'Station B',
    departure_date: departure_time.to_date,     # Extract the date part
    departure_time: departure_time.strftime('%H:%M'), # Format time as 'HH:MM'
    arrival_date: (departure_time + 1.day).to_date, # Add 1 day for arrival date
    arrival_time: (departure_time + 1.hour).strftime('%H:%M'), # Add 1 hour for arrival time
    ticket_price: 50.0,
    train_capacity: 100,
    seats_left: 100
  )