require 'rails_helper'

RSpec.describe 'Recipes Requests', :vcr do
  describe 'endpoint' do
    it 'hits the endpoint' do 
      get "/api/v1/recipes?country=laos" 
      expect(response).to be_successful
    end
    
    it 'returns serialized json' do 
      get "/api/v1/recipes?country=laos" 
      recipes = JSON.parse(response.body, symbolize_names: true)[:data]
      recipes.each do |recipe|
        check_hash_structure(recipe, :attributes, Hash)
        check_hash_structure(recipe, :type, String)
        check_hash_structure(recipe[:attributes], :title, String)
        check_hash_structure(recipe[:attributes], :url, String)
        check_hash_structure(recipe[:attributes], :image, String)
        check_hash_structure(recipe[:attributes], :country, String)
        expect(recipe[:attributes][:country]).to eq('Laos')
        expect(recipe).to_not have_key(:source)
        expect(recipe).to_not have_key(:uri)
      end
    end
  end

  describe 'sad paths' do 
    it 'if no country given, returns recipes from random country' do 
      get '/api/v1/recipes' 

      expect(response).to be_successful
      
      recipes = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(recipes).to be_a Array
      expect(recipes).to_not be_empty

      recipes.each do |recipe|
        check_hash_structure(recipe, :attributes, Hash)
        check_hash_structure(recipe, :type, String)
        check_hash_structure(recipe[:attributes], :title, String)
        check_hash_structure(recipe[:attributes], :url, String)
        check_hash_structure(recipe[:attributes], :image, String)
        check_hash_structure(recipe[:attributes], :country, String)
        expect(recipe).to_not have_key(:source)
        expect(recipe).to_not have_key(:uri)
        expect(recipe[:attributes][:title]).to_not be_empty
      end
    end

    it 'if nothing returned, response is an empty data array' do
      get '/api/v1/recipes?country=sudan'
      
      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to eq({ data: [] })
    end
  end
end