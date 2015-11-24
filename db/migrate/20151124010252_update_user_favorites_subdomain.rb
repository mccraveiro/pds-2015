class UpdateUserFavoritesSubdomain < ActiveRecord::Migration
  def change
    add_column :user_favorites, :subdomain_id, :integer
    remove_column :user_favorites, :subdomain
  end
end
