class CreateUserHistoryTable < ActiveRecord::Migration
  def change
    create_table :user_history do |t|
      t.integer :user_id
      t.integer :domain_id
      t.integer :subdomain_id
      t.integer :nature_id
      t.string :city
      t.string :month
      t.string :year
      t.timestamps null: false
      t.boolean :favorite, default: false
    end
  end
end
