json.extract! user, :id, :name, :email_address, :address, :phone_number, :created_at, :updated_at, :credit_number
json.url user_url(user, format: :json)
