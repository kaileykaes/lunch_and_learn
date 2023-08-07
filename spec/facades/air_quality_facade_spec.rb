require 'rails_helper'

RSpec.describe AirQualityFacade do
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
      expect(response.aqi).to eq(84)
      expect(response.city).to eq('Paris')
      expect(response.co_concentration).to eq(220.3)
      expect(response.pm25_concentration).to eq(2.74)
      expect(response.id).to eq('null')
    end
  end
end