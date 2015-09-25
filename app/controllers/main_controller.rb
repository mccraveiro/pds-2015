class MainController < ApplicationController
  def index
    @domains = Domain.order(:value).all
    @subdomains = Subdomain.order(:value).all
    @natures = Nature.order(:value).all
  end
end
