require 'ostruct'
require 'savon'
require 'nokogiri'
require 'open-uri'

class MainController < ApplicationController
  def index
    @months = [
      OpenStruct.new({ name: 'Janeiro', value: '01'}),
      OpenStruct.new({ name: 'Fevereiro', value: '02'}),
      OpenStruct.new({ name: 'Março', value: '03'}),
      OpenStruct.new({ name: 'Abril', value: '04'})
    ]
    @domains = Domain.order(:label).all
    @subdomains = Subdomain.order(:label).all
    @natures = Nature.order(:label).all

    @totais = get_total_despesa params[:city], params[:year], params[:month], params[:domain], params[:subdomain], params[:nature]
    @total = @totais.inject(0) { |sum, n| sum + n.to_f }

    if current_user
      @despesas = get_lista_despesa params[:city], params[:year], params[:month], params[:domain], params[:subdomain], params[:nature], params[:first]
      puts "First = " + @first.to_s
      puts "Getting all expenses"
    end
  end

  def get_total_despesa(city = "", year = "", month = "", domain = "", subdomain = "", nature = "")

    city = 'Campinas' if city.blank?
    year = '2014' if year.blank?

    months = if month.blank?
      ['01', '02', '03', '04']#, '05', '06', '07', '08', '09', '10', '11', '12', '']
    else
      [month]
    end

    months.map { |m|
      body = call_api(1, city, year, m, domain, subdomain, nature, 0, 0)
      body[:get_total_despesa_response][:get_total_despesa_result]
    }
  end

  def get_lista_despesa(city = "", year = "", month = "", domain = "", subdomain = "", nature = "", first = nil)

    city = 'Campinas' if city.blank?
    year = '2014' if year.blank?

    months = if month.blank?
      ['01', '02', '03', '04']#, '05', '06', '07', '08', '09', '10', '11', '12', '']
    else
      [month]
    end

    first = 1 if first.nil?
    elems = 10

    first = first.to_i

    @first = first

    expenses = Array.new

    totalElems = 0
    totalExpensesInPage = 0

    months.map { |m|
      body = call_api(2, city, year, m, domain, subdomain, nature, first, elems)
      #puts body[:get_lista_despesa_response][:get_lista_despesa_result]

      data = Nokogiri::XML(body[:get_lista_despesa_response][:get_lista_despesa_result])
      d = data.xpath('//Despesa').each do |link|
        c = link.children
        e = Expense.new
        e.codigo = c[1].content.strip
        e.codigoMunicipio = c[3].content.strip
        e.codigoUF = c[5].content.strip
        e.codigoPais = c[7].content.strip
        e.codigoOrgao = c[9].content.strip
        e.codigoPrograma = c[11].content.strip
        e.codigoDominio = c[13].content.strip
        e.codigoSubDominio = c[15].content.strip
        e.codigoFonte = c[17].content.strip
        e.codigoNatureza = c[19].content.strip
        e.codigoTipoLicitacao = c[21].content.strip
        e.dataAno = c[23].content.strip
        e.dataMes = c[25].content.strip
        e.valor = c[27].content.strip
        e.descricaoOrgao = c[29].content.strip
        e.cpfCnpjCredor = c[31].content.strip
        e.descricaoPrograma = c[33].content.strip
        e.descricaoDominio = c[35].content.strip
        e.descricaoSubDominio = c[37].content.strip
        e.descricaoFonte = c[39].content.strip
        e.descricaoNatureza = c[41].content.strip
        e.descricaoTipoLicitacao = c[43].content.strip
        e.dominio = Domain.where('value LIKE ?', "#{e.descricaoDominio}%").first.label
        e.subdominio = Subdomain.where('value LIKE ?', "#{e.descricaoSubDominio}%").first.label
        e.natureza = Nature.where('value LIKE ?', "#{e.descricaoNatureza}%").first.label

        expenses.push(e)
      end

      d = data.xpath('//TotalCount')
      countCurrentMonth = d.children[0].content.to_i
      totalExpensesInPage = totalExpensesInPage + expenses.size
      totalElems = totalElems + countCurrentMonth

      if totalExpensesInPage >= 10
        break
      elsif totalExpensesInPage > 0
        elems = 10 - totalExpensesInPage
        first = 1
      else
        first = first - countCurrentMonth
      end
    }

    expenses
  end

  private
  def call_api(f, city, year, month, domain, subdomain, nature, first, elems)
    # create a client for the service
    client = Savon.client(wsdl: 'http://transparenciaws.elasticbeanstalk.com/TransparenciaWS.asmx?WSDL')

    puts "call_api f = " + f.to_s + " Month = " + month + " First = " + first.to_s + " Elems = " + elems.to_s

    if f == 1
      response = client.call(:get_total_despesa, message: {
        wNomeCidade: city,
        wAno: year,
        wMes: month,
        wDominio: domain,
        wSubDominio: subdomain,
        wNatureza: nature
      })
    else
      response = client.call(:get_lista_despesa, message: {
        wNomeCidade: city,
        wAno: year,
        wMes: month,
        wDominio: domain,
        wSubDominio: subdomain,
        wNatureza: nature,
        wInicioRegistros: first.to_s,
        wQuantidadeRegistros: elems
      })
    end

    response.body
  end
end
