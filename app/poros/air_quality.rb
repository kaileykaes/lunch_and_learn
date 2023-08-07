class AirQuality
  attr_reader   :id,
                :city, 
                :aqi, 
                :pm25_concentration, 
                :co_concentration
  
  def initialize(attributes, city)
    @id = nil.to_json
    @city = city.capitalize
    @aqi = attributes[:overall_aqi]
    @pm25_concentration = attributes[:"PM2.5"][:concentration]
    @co_concentration = attributes[:CO][:concentration]
  end
end