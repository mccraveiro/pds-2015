class UpdateDomains < ActiveRecord::Migration
  def up
    add_column :domains, :label, :string
    execute "UPDATE domains SET label = 'Educação' WHERE value = '12 - EDUCACAO                                     '"
    execute "UPDATE domains SET label = 'Saúde' WHERE value = '10 - SAUDE                                        '"
  end

  def down
    remove_column :domains, :label
  end
end
