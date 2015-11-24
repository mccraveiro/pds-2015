class UpdateUserFavoritesDomain < ActiveRecord::Migration
  def change
    add_column :user_favorites, :domain_id, :integer
    remove_column :user_favorites, :domain
  end
end
