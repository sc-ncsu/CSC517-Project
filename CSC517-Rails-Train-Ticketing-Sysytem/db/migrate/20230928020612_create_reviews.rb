class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :feedback
      t.references :user, null: false, foreign_key: true
      t.references :train, null: false, foreign_key: true

      t.timestamps
    end
  end
end
