require 'ostruct'
require 'savon'
require 'nokogiri'
require 'open-uri'

class CompareController < ApplicationController
  def index
    @months = [
      OpenStruct.new({ name: 'Janeiro', value: '01'}),
      OpenStruct.new({ name: 'Fevereiro', value: '02'})
    ]
    @domains = Domain.order(:label).all
    @subdomains = Subdomain.order(:label).all
    @natures = Nature.order(:value).all

    params_1 = get_params("1")
    params_2 = get_params("2")

    @totais = {
      "1" => get_total_despesa(params_1[:city], params_1[:year], params_1[:month], params_1[:domain], params_1[:subdomain], params_1[:nature]),
      "2" => get_total_despesa(params_2[:city], params_2[:year], params_2[:month], params_2[:domain], params_2[:subdomain], params_2[:nature])
    }

    @total = {
      "1" => @totais["1"].inject(0) { |sum, n| sum + n.to_f },
      "2" => @totais["2"].inject(0) { |sum, n| sum + n.to_f }
    }
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

  private
  def get_params(index)
    {
      :city => params[:city].present? ? params[:city][index] : nil,
      :year => params[:year].present? ? params[:year][index] : nil,
      :month => params[:month].present? ? params[:month][index] : nil,
      :domain => params[:domain].present? ? params[:domain][index] : nil,
      :subdomain => params[:subdomain].present? ? params[:subdomain][index] : nil,
      :nature => params[:nature].present? ? params[:nature][index] : nil
    }
  end

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
