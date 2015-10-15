require 'savon'
require 'nokogiri'
require 'open-uri'

class MainController < ApplicationController
  def index
    @domains = Domain.order(:value).all
    @subdomains = Subdomain.order(:value).all
    @natures = Nature.order(:value).all
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

    expenses = []

    months.map { |m|
      body = call_api(2, city, year, m, domain, subdomain, nature)
      #body[:get_lista_despesa_response][:get_lista_despesa_result]

      data = Nokogiri::XML(body[:get_lista_despesa_response][:get_lista_despesa_result])
      d = data.xpath('//Despesa').each do |link|
        c = link.children
        expenses << Expense.new(c[1].content.strip ,c[3].content.strip ,c[5].content.strip ,c[7].content.strip ,c[9].content.strip ,c[11].content.strip ,c[13].content.strip ,c[15].content.strip ,c[17].content.strip ,c[19].content.strip ,c[21].content.strip ,c[23].content.strip ,c[25].content.strip ,c[27].content.strip ,c[29].content.strip ,c[31].content.strip ,c[33].content.strip ,c[35].content.strip ,c[37].content.strip ,c[39].content.strip ,c[41].content.strip ,c[43].content.strip)
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
