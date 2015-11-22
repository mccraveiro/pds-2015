class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
      t.integer :user_id
      t.string :domain
      t.string :subdomain
      t.string :nature
      t.string :city
      t.string :month
      t.string :year
      t.timestamps null: false
    end
  end
end
