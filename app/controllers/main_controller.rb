require 'ostruct'
require 'savon'
require 'nokogiri'
require 'open-uri'

class MainController < ApplicationController
  def index
    @months = [
      OpenStruct.new({ name: 'Janeiro', value: '01'}),
      OpenStruct.new({ name: 'Fevereiro', value: '02'})
    ]
    @domains = Domain.order(:value).all
    @subdomains = Subdomain.order(:value).all
    @natures = Nature.order(:value).all

    @totais = get_total_despesa params[:city], params[:year], params[:month], params[:domain], params[:subdomain], params[:nature]
    @total = @totais.inject(0) { |sum, n| sum + n.to_f }

    if current_user
      @despesas = get_lista_despesa params[:city], params[:year], params[:month], params[:domain], params[:subdomain], params[:nature]
      puts "Getting all expenses"
    end
  end

  def get_total_despesa(city = "", year = "", month = "", domain = "", subdomain = "", nature = "")

    city = 'Campinas' if city.blank?
    year = '2014' if year.blank?

    months = if month.blank?
      ['01', '02']#, '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '']
    else
      [month]
    end

    months.map { |m|
      body = call_api(1, city, year, m, domain, subdomain, nature)
      body[:get_total_despesa_response][:get_total_despesa_result]
    }
  end

  def get_lista_despesa(city = "", year = "", month = "", domain = "", subdomain = "", nature = "")

    city = 'Campinas' if city.blank?
    year = '2014' if year.blank?

    months = if month.blank?
      ['01', '02']#, '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '']
    else
      [month]
    end

    expenses = Array.new

    months.map { |m|
      body = call_api(2, city, year, m, domain, subdomain, nature)
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

        expenses.push(e)
      end
    }

    expenses
  end

  private
  def call_api(f, city, year, month, domain, subdomain, nature)
    # create a client for the service
    client = Savon.client(wsdl: 'http://transparenciaws.elasticbeanstalk.com/TransparenciaWS.asmx?WSDL')

    fun = if f == 1
      :get_total_despesa
    else
      :get_lista_despesa
    end

    response = client.call(fun, message: {
      wNomeCidade: city,
      wAno: year,
      wMes: month,
      wDominio: domain,
      wSubDominio: subdomain,
      wNatureza: nature
    })

    response.body
  end
end
