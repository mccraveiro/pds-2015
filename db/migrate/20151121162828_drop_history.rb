class DropHistory < ActiveRecord::Migration
  def change
    drop_table :user_history
  end
end
