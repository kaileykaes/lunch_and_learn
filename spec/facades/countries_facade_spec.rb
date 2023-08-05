require 'rails_helper'

RSpec.describe CountriesFacade do
  before(:each) do 
    @cf = CountriesFacade.new
  end

  describe 'initialize' do 
    it 'exists' do 
      expect(@cf).to be_a CountriesFacade
    end
  end

  describe 'creates countries' do
    it 'all_countries' do 
      response = @cf.all_countries

      expect(response).to be_a Array
      
      response.each do |r|
        expect(r).to have_key(:name)
        expect(r[:name]).to be_a Hash
        expect(r[:name]).to have_key(:common)
        expect(r[:name][:common]).to be_a String
      end
    end

    it 'random_country_name' do 
      country_name = @cf.random_country_name

      countries = @cf.all_countries

      country_names = countries.map do |country|
        country[:name][:common]
      end

      expect(country_names).to include(country_name)
    end
  end
end