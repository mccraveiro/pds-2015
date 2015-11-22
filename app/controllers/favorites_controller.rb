require 'ostruct'
require 'uri'

class FavoritesController < ApplicationController
  def index
    @months = [
      OpenStruct.new({ name: 'Janeiro', value: '01'}),
      OpenStruct.new({ name: 'Fevereiro', value: '02'}),
      OpenStruct.new({ name: 'Março', value: '03'}),
      OpenStruct.new({ name: 'Abril', value: '04'}),
      OpenStruct.new({ name: 'Maio', value: '05'}),
      OpenStruct.new({ name: 'Junho', value: '06'}),
      OpenStruct.new({ name: 'Julho', value: '07'}),
      OpenStruct.new({ name: 'Agosto', value: '08'}),
      OpenStruct.new({ name: 'Setembro', value: '09'}),
      OpenStruct.new({ name: 'Outubro', value: '10'}),
      OpenStruct.new({ name: 'Novembro', value: '11'}),
      OpenStruct.new({ name: 'Dezembro', value: '12'})
    ]
    @favorites = UserFavorites.where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    search_params = params.permit(:user_id, :domain, :subdomain, :nature, :city, :month, :year)
    @user = UserFavorites.new(search_params)
    @user.save
    head :ok
  end

  def delete
    UserFavorites.find(params[:id]).destroy
    redirect_to favorites_path
  end
end
