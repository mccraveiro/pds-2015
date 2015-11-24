class UpdateNatures < ActiveRecord::Migration
  def up
    add_column :natures, :label, :string

    execute "UPDATE natures SET label = 'Contratação por tempo determinado' WHERE value = '31900400 - CONTRATACAO POR TEMPO DETERMINADO            '"
    execute "UPDATE natures SET label = 'Vencimentos e vantagens fixas - pessoal civil' WHERE value = '31901100 - VENCIMENTOS E VANTAGENS FIXAS - PESSOAL CIVIL'"
    execute "UPDATE natures SET label = 'Obrigações Patronais - intra-orçamentário' WHERE value = '31911300 - OBRIGACOES PATRONAIS - INTRA-ORCAMENTARIO    '"
    execute "UPDATE natures SET label = 'Material de consumo' WHERE value = '33903000 - MATERIAL DE CONSUMO                          '"
    execute "UPDATE natures SET label = 'Serviços de consultoria' WHERE value = '33903500 - SERVICOS DE CONSULTORIA                      '"
    execute "UPDATE natures SET label = 'Outros serviços de terceiros - pessoa física' WHERE value = '33903600 - OUTROS SERVICOS DE TERCEIROS - PESSOA FISICA '"
    execute "UPDATE natures SET label = 'Outros serviços de terceiros - pessoa jurídica' WHERE value = '33903900 - OUTROS SERVICOS DE TERCEIROS-PESSOA JURIDICA '"
    execute "UPDATE natures SET label = 'Obrigações tributárias e contributivas' WHERE value = '33904700 - OBRIGACOES TRIBUTARIAS E CONTRIBUTIVAS       '"
    execute "UPDATE natures SET label = 'Obras e instalações' WHERE value = '44905100 - OBRAS E INSTALACOES                          '"
    execute "UPDATE natures SET label = 'Equipamentos e material permanente' WHERE value = '44905200 - EQUIPAMENTOS E MATERIAL PERMANENTE           '"
  end

  def down
    remove_column :natures, :label
  end
end
