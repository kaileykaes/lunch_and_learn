require 'rails_helper'

RSpec.describe 'Recipes Requests' do
  before(:each) do
    get "/api/v1/recipes?country=laos" 
  end

  describe 'endpoint' do
    it 'hits the endpoint' do 
      expect(response).to be_successful
    end

    it 'returns serialized json' do 
      recipes = JSON.parse(response.body, symbolize_names: true)[:data]
      recipes.each do |recipe|
        check_hash_structure(recipe, :attributes, Hash)
        check_hash_structure(recipe, :type, String)
        check_hash_structure(recipe[:attributes], :title, String)
        check_hash_structure(recipe[:attributes], :url, String)
        check_hash_structure(recipe[:attributes], :image, String)
        check_hash_structure(recipe[:attributes], :country, String)
        expect(recipe).to_not have_key(:source)
        expect(recipe).to_not have_key(:uri)
      end
    end
  end
end