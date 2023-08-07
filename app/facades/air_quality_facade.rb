class AirQualityFacade
  def air_quality_by_country(country)
    city = CountriesFacade.new.capital_by_country(country)
    info = AirQualityService.endpoint(city)
    create_air_quality(info, city)
  end

  private
  def create_air_quality(air_quality_data, city)
    AirQuality.new(air_quality_data, city)
  end
end