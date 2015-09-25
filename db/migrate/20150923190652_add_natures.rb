class AddNatures < ActiveRecord::Migration
  def up
    execute "INSERT INTO natures (value) VALUES ('31900400 - CONTRATACAO POR TEMPO DETERMINADO            ')"
    execute "INSERT INTO natures (value) VALUES ('31901100 - VENCIMENTOS E VANTAGENS FIXAS - PESSOAL CIVIL')"
    execute "INSERT INTO natures (value) VALUES ('31911300 - OBRIGACOES PATRONAIS - INTRA-ORCAMENTARIO    ')"
    execute "INSERT INTO natures (value) VALUES ('33903000 - MATERIAL DE CONSUMO                          ')"
    execute "INSERT INTO natures (value) VALUES ('33903500 - SERVICOS DE CONSULTORIA                      ')"
    execute "INSERT INTO natures (value) VALUES ('33903600 - OUTROS SERVICOS DE TERCEIROS - PESSOA FISICA ')"
    execute "INSERT INTO natures (value) VALUES ('33903900 - OUTROS SERVICOS DE TERCEIROS-PESSOA JURIDICA ')"
    execute "INSERT INTO natures (value) VALUES ('33904700 - OBRIGACOES TRIBUTARIAS E CONTRIBUTIVAS       ')"
    execute "INSERT INTO natures (value) VALUES ('44905100 - OBRAS E INSTALACOES                          ')"
    execute "INSERT INTO natures (value) VALUES ('44905200 - EQUIPAMENTOS E MATERIAL PERMANENTE           ')"
  end

  def down
    execute "DELETE FROM natures WHERE value = '31900400 - CONTRATACAO POR TEMPO DETERMINADO            '"
    execute "DELETE FROM natures WHERE value = '31901100 - VENCIMENTOS E VANTAGENS FIXAS - PESSOAL CIVIL'"
    execute "DELETE FROM natures WHERE value = '31911300 - OBRIGACOES PATRONAIS - INTRA-ORCAMENTARIO    '"
    execute "DELETE FROM natures WHERE value = '33903000 - MATERIAL DE CONSUMO                          '"
    execute "DELETE FROM natures WHERE value = '33903500 - SERVICOS DE CONSULTORIA                      '"
    execute "DELETE FROM natures WHERE value = '33903600 - OUTROS SERVICOS DE TERCEIROS - PESSOA FISICA '"
    execute "DELETE FROM natures WHERE value = '33903900 - OUTROS SERVICOS DE TERCEIROS-PESSOA JURIDICA '"
    execute "DELETE FROM natures WHERE value = '33904700 - OBRIGACOES TRIBUTARIAS E CONTRIBUTIVAS       '"
    execute "DELETE FROM natures WHERE value = '44905100 - OBRAS E INSTALACOES                          '"
    execute "DELETE FROM natures WHERE value = '44905200 - EQUIPAMENTOS E MATERIAL PERMANENTE           '"
  end
end
