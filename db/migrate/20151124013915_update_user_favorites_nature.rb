class UpdateUserFavoritesNature < ActiveRecord::Migration
  def change
    add_column :user_favorites, :nature_id, :integer
    remove_column :user_favorites, :nature
  end
end
