require 'rails_helper'

RSpec.describe AirQuality do
  before(:each) do
    info = File.read("spec/fixtures/air_qualities/paris_air_quality.json")
    air_quality_info = JSON.parse(info, symbolize_names: true)
    @aq = AirQuality.new(air_quality_info, 'Paris')
  end

  describe 'initialize' do 
    it 'exists' do 
      expect(@aq).to be_a AirQuality
    end

    it 'has attributes' do 
      expect(@aq.city).to eq('Paris')
      expect(@aq.aqi).to eq(102)
      expect(@aq.pm25_concentration).to eq(2.95)
      expect(@aq.co_concentration).to eq(216.96)
      expect(@aq.id).to eq('null')
    end
  end
end