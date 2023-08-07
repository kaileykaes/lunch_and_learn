class Api::V1::AirQualityController < ApplicationController
  def index
    unless params[:country].present? 
      params[:country] = CountriesFacade.new.random_country_name
    end
      air_quality = AirQualityFacade.new.air_quality_by_country(params[:country])
      render json: AirQualitySerializer.format_air_quality(air_quality)
  end
end