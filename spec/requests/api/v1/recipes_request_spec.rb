require 'rails_helper'

RSpec.describe 'Recipes Requests' do
  describe 'endpoint' do
    it 'hits the endpoint' do 
      headers = { "CONTENT_TYPE" => "application/json"}
      get "/api/v1/recipes?country=laos", headers: headers
      expect(response).to be_successful
    end
    
    it 'returns serialized json', :vcr do 
      headers = { "CONTENT_TYPE" => "application/json"}
      get "/api/v1/recipes?country=laos", headers: headers
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
      response = Net::HTTPSuccess.new(1.0, 200, 'OK')
      stub_request(:get, "/api/v1/recipes")
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.10'
          })
      .to_return(response)
          
      expect(response.code).to eq(200)           
      
      json_response = File.read("spec/fixtures/recipes/random_recipe.json")
      recipes = JSON.parse(json_response, symbolize_names: true)[:data]
      
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
    
    it 'if nothing returned, response is an empty data array', :vcr do
      headers = { "CONTENT_TYPE" => "application/json"}
      get "/api/v1/recipes?country=sudan", headers: headers
      
      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to eq({ data: [] })
    end
  end
end