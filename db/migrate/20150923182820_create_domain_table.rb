class CreateDomainTable < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :value
    end
  end
end
