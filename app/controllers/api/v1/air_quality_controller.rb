class Api::V1::AirQualityController < ApplicationController
  def index
    air_quality = AirQualityFacade.new.air_quality_by_country('Nigeria')
    render json: AirQualitySerializer.new(air_quality).serializable_hash.to_json
  end
end