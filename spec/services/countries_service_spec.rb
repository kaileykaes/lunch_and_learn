require 'rails_helper'

RSpec.describe 'Countries Service' do
  describe 'class methods', :vcr do 
    it '#all_countries' do 
      response = CountriesService.all_countries

      expect(response).to be_a Array
      
      response.each do |r|
        expect(r).to have_key(:name)
        expect(r[:name]).to be_a Hash
        expect(r[:name]).to have_key(:common)
        expect(r[:name][:common]).to be_a String
      end
    end

    it '' do 
    end
  end
end