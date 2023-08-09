require 'rails_helper'

RSpec.describe Country do
  before(:each) do
    country_info = File.read("spec/fixtures/countries/one_country.json")
    
    params = JSON.parse(country_info, symbolize_names: true).first

    @country = Country.new(params)
  end

  describe 'initialize' do 
    it 'exists' do 
      expect(@country).to be_a Country
    end

    it 'has attributes' do 
      expect(@country.common_name).to eq('Uruguay')
      expect(@country.official_name).to eq('Oriental Republic of Uruguay')
      expect(@country.capital).to eq('Montevideo')
    end
  end
end