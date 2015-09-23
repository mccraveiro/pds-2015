class AddDomains < ActiveRecord::Migration
  def up
    execute "INSERT INTO domains (value) VALUES ('12 - EDUCACAO                                     ')"
    execute "INSERT INTO domains (value) VALUES ('10 - SAUDE                                        ')"
  end

  def down
    execute "DELETE FROM domains WHERE value = '12 - EDUCACAO                                     '"
    execute "DELETE FROM domains WHERE value = '10 - SAUDE                                        '"
  end
end
