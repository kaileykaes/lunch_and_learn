require 'rails_helper'

RSpec.describe 'Air Quality Serializer' do
  describe 'serialization' do
    it 'serializes a single air quality object' do 
      air_quality = AirQualityFacade.new.air_quality_by_country('Nigeria')

      serialized_air_quality = AirQualitySerializer.format_air_quality(air_quality)
      expect(serialized_air_quality).to be_a String

      parsed_air_quality = JSON.parse(serialized_air_quality, symbolize_names: true)

      expect(parsed_air_quality).to be_a Hash
      check_hash_structure(parsed_air_quality, :data, Hash)
      expect(parsed_air_quality[:data][:id]).to eq(nil.to_json)
      check_hash_structure(parsed_air_quality[:data], :type, String)
      check_hash_structure(parsed_air_quality[:data], :city, String)
      check_hash_structure(parsed_air_quality[:data], :attributes, Hash)

      attributes = parsed_air_quality[:data][:attributes]

      check_hash_structure(attributes, :aqi, Integer)
      check_hash_structure(attributes, :pm25_concentration, Float)
      check_hash_structure(attributes, :co_concentration, Float)
    end
  end
end