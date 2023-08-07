require 'rails_helper'

RSpec.describe 'Air Quality Request 'do
  describe 'endpoint' do

    it 'hits the endpoint' do 
      get "/api/v1/air_quality?country=Nigeria"
      expect(response).to be_successful
    end
    
    it 'returns serialized json' do 
      get "/api/v1/air_quality?country=Nigeria"
      air_quality = JSON.parse(response.body, symbolize_names: true)

      expect(air_quality).to be_a Hash
      check_hash_structure(air_quality, :data, Hash)
      expect(air_quality[:data][:id]).to eq(nil.to_json)
      check_hash_structure(air_quality[:data], :type, String)
      check_hash_structure(air_quality[:data], :attributes, Hash)
      check_hash_structure(air_quality[:data], :city, String)
      expect(air_quality[:data][:city]).to eq('Abuja')
      
      attributes = air_quality[:data][:attributes]
      check_hash_structure(attributes, :aqi, Integer)
      check_hash_structure(attributes, :pm25_concentration, Float)
      check_hash_structure(attributes, :co_concentration, Float)
    end

    it 'if no city given, returns air quality of random city' do 
      get '/api/v1/air_quality'
      
      expect(response).to be_successful
      
      air_quality = JSON.parse(response.body, symbolize_names: true)
      
      expect(air_quality).to be_a Hash
      check_hash_structure(air_quality, :data, Hash)
      expect(air_quality[:data][:id]).to eq(nil.to_json)
      check_hash_structure(air_quality[:data], :type, String)
      check_hash_structure(air_quality[:data], :attributes, Hash)
      check_hash_structure(air_quality[:data], :city, String)
      expect(air_quality[:data][:city]).to_not be_empty

      attributes = air_quality[:data][:attributes]
      check_hash_structure(attributes, :aqi, Integer)
      check_hash_structure(attributes, :pm25_concentration, Float)
      check_hash_structure(attributes, :co_concentration, Float)
    end
  end
end