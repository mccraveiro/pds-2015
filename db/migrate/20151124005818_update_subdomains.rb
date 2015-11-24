class UpdateSubdomains < ActiveRecord::Migration
  def up
    add_column :subdomains, :label, :string
    execute "UPDATE subdomains SET label = 'Administração Geral' WHERE value = '122 - ADMINISTRACAO GERAL                            '"
    execute "UPDATE subdomains SET label = 'Assistência Hospitalar e Ambulatorial' WHERE value = '302 - ASSISTENCIA HOSPITALAR E AMBULATORIAL          '"
    execute "UPDATE subdomains SET label = 'Vigilância Sanitária' WHERE value = '304 - VIGILANCIA SANITARIA                           '"
    execute "UPDATE subdomains SET label = 'Ensino Fundamental' WHERE value = '361 - ENSINO FUNDAMENTAL                             '"
    execute "UPDATE subdomains SET label = 'Ensino Profissional' WHERE value = '363 - ENSINO PROFISSIONAL                            '"
    execute "UPDATE subdomains SET label = 'Educação de Jovens e Adultos' WHERE value = '366 - EDUCACAO DE JOVENS E ADULTOS                   '"
  end

  def down
    remove_column :subdomains, :label
  end
end
