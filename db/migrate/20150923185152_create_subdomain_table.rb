class CreateSubdomainTable < ActiveRecord::Migration
  def change
    create_table :subdomains do |t|
      t.string :value
    end
  end
end
