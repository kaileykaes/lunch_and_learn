require 'rails_helper'

RSpec.describe AirQualityService do
  describe 'class methods', :vcr do 
    it '#endpoint' do 
      response = AirQualityService.endpoint("prague")

      expect(response).to be_a Hash
      
    
      check_hash_structure(response, :overall_aqi, Integer)
      check_hash_structure(response, :CO, Hash)
      check_hash_structure(response[:CO], :concentration, Float)
      check_hash_structure(response[:CO], :aqi, Integer)

      check_hash_structure(response, :NO2, Hash)
      check_hash_structure(response[:NO2], :concentration, Float)
      check_hash_structure(response[:NO2], :aqi, Integer)

      check_hash_structure(response, :O3, Hash)
      check_hash_structure(response[:O3], :concentration, Float)
      check_hash_structure(response[:O3], :aqi, Integer)

      check_hash_structure(response, :SO2, Hash)
      check_hash_structure(response[:SO2], :concentration, Float)
      check_hash_structure(response[:SO2], :aqi, Integer)

      check_hash_structure(response, :"PM2.5", Hash)
      check_hash_structure(response[:"PM2.5"], :concentration, Float)
      check_hash_structure(response[:"PM2.5"], :aqi, Integer)

      check_hash_structure(response, :PM10, Hash)
      check_hash_structure(response[:PM10], :concentration, Float)
      check_hash_structure(response[:PM10], :aqi, Integer)
    end
  end
end