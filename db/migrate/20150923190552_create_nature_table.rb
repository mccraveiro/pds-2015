class CreateNatureTable < ActiveRecord::Migration
  def change
    create_table :natures do |t|
      t.string :value
    end
  end
end
