require 'savon'

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

    months.map { |m| call_api(1, city, year, m, domain, subdomain, nature) }
  end

  def get_lista_despesa(city = "", year = "", month = "", domain = "", subdomain = "", nature = "")

    city = 'Campinas' if city.blank?
    year = '2014' if year.blank?

    months = if month.blank?
      ['01', '02']#, '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '']
    else
      [month]
    end

    months.map { |m| call_api(2, city, year, m, domain, subdomain, nature) }
  end

  private
  def call_api(f, city, year, month, domain, subdomain, nature)
    # create a client for the service
    client = Savon.client(wsdl: 'http://transparenciaws.elasticbeanstalk.com/TransparenciaWS.asmx?WSDL')

    if f == 1
      response = client.call(:get_total_despesa, message: {
        wNomeCidade: city,
        wAno: year,
        wMes: month,
        wDominio: domain,
        wSubDominio: subdomain,
        wNatureza: nature
      })
      response.body[:get_total_despesa_response][:get_total_despesa_result]
    else
      response = client.call(:get_lista_despesa, message: {
        wNomeCidade: city,
        wAno: year,
        wMes: month,
        wDominio: domain,
        wSubDominio: subdomain,
        wNatureza: nature
      })
      response.body[:get_lista_despesa_response][:get_lista_despesa_result]
    end
  end
end
