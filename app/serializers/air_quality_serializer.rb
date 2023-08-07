class AirQualitySerializer
  include JSONAPI::Serializer
  attributes :aqi, :pm25_concentration, :co_concentration, :city

  def self.format_air_quality(air_quality)
    { data:
      {   id: air_quality.id,
          type: "air_quality",
          city: air_quality.city,
          attributes: 
            { aqi: air_quality.aqi,
              pm25_concentration: air_quality.pm25_concentration,
              co_concentration: air_quality.co_concentration
            } 
      }
    }.to_json
  end
end


