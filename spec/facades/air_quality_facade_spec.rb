require 'rails_helper'

RSpec.describe AirQualityFacade, :vcr do
  before(:each) do 
    @aqf = AirQualityFacade.new
  end

  describe 'initialize' do 
    it 'exists' do 
      expect(@aqf).to be_a AirQualityFacade
    end
  end

  describe 'creates air quality' do
    it 'air_quality_by_country' do 
      response = @aqf.air_quality_by_country('France')

      expect(response).to be_a AirQuality
      expect(response.aqi).to be_an Integer
      expect(response.city).to eq('Paris')
      expect(response.co_concentration).to be_a Float
      expect(response.pm25_concentration).to be_a Float
      expect(response.id).to eq('null')
    end
  end
end