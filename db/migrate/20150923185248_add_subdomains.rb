class AddSubdomains < ActiveRecord::Migration
  def up
    execute "INSERT INTO subdomains (value) VALUES ('122 - ADMINISTRACAO GERAL                            ')"
    execute "INSERT INTO subdomains (value) VALUES ('302 - ASSISTENCIA HOSPITALAR E AMBULATORIAL          ')"
    execute "INSERT INTO subdomains (value) VALUES ('304 - VIGILANCIA SANITARIA                           ')"
    execute "INSERT INTO subdomains (value) VALUES ('361 - ENSINO FUNDAMENTAL                             ')"
    execute "INSERT INTO subdomains (value) VALUES ('363 - ENSINO PROFISSIONAL                            ')"
    execute "INSERT INTO subdomains (value) VALUES ('366 - EDUCACAO DE JOVENS E ADULTOS                   ')"
  end

  def down
    execute "DELETE FROM subdomains WHERE value = '122 - ADMINISTRACAO GERAL                            '"
    execute "DELETE FROM subdomains WHERE value = '302 - ASSISTENCIA HOSPITALAR E AMBULATORIAL          '"
    execute "DELETE FROM subdomains WHERE value = '304 - VIGILANCIA SANITARIA                           '"
    execute "DELETE FROM subdomains WHERE value = '361 - ENSINO FUNDAMENTAL                             '"
    execute "DELETE FROM subdomains WHERE value = '363 - ENSINO PROFISSIONAL                            '"
    execute "DELETE FROM subdomains WHERE value = '366 - EDUCACAO DE JOVENS E ADULTOS                   '"
  end
end
