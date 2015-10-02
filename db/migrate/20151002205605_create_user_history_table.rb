class CreateUserHistoryTable < ActiveRecord::Migration
  def change
    create_table :user_history do |t|
	t.integer :id_user
	t.integer :id_domain
	t.integer :id_subdomain
	t.integer :id_nature	
	t.string :city
	t.string :mounth
	t.string :year
	t.timestamps null: false
	t.boolean :favorite
    end
  end
end
