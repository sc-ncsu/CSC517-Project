class InsertSampleAdminUser < ActiveRecord::Migration[7.0]
  def up
    User.create!(
      name: 'Admin',
      email_address: 'admin@example.com',
      password: 'admin', # This will be securely hashed by has_secure_password
      address: 'Admin Address',
      phone_number: '123-456-7890',
      credit_number: '1234-5678-9012-3456',
      admin: true
    )
  end

  def down
    admin_user = User.find_by(email_address: 'admin@example.com')
    admin_user.destroy if admin_user
  end
end
