require 'rails_helper'

RSpec.describe AirQuality do
  before(:each) do
    info = File.read("spec/fixtures/air_qualities/dubai_air_quality.json")
    air_quality_info = JSON.parse(info, symbolize_names: true)
    @aq = AirQuality.new(air_quality_info, 'dubai')
  end

  describe 'initialize' do 
    it 'exists' do 
      expect(@aq).to be_a AirQuality
    end

    it 'has attributes' do 
      expect(@aq.city).to eq('Dubai')
      expect(@aq.aqi).to eq(500)
      expect(@aq.pm25_concentration).to eq(152.05)
      expect(@aq.co_concentration).to eq(347.14)
      expect(@aq.id).to eq('null')
    end
  end
end