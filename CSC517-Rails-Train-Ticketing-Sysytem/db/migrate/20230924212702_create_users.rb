class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email_address
      t.string :password_digest
      t.text :address
      t.string :phone_number
      t.string :credit_number

      t.timestamps
    end
    add_index :users, :email_address, unique: true
  end
end
