require 'rails_helper'

RSpec.describe 'Favorites Requests', type: :request do
  before(:each) do 
    @user = create(:user)
    @headers = { "CONTENT_TYPE" => "application/json"} 
  end

  describe 'favorite creation' do
    it 'successfully posts a favorite and returns success message' do 
      favorite_params = {
        "api_key": @user.api_key,
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }
      
      post '/api/v1/favorites', params: favorite_params, headers: @headers, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      success_message = JSON.parse(response.body, symbolize_names: true)

      expect(success_message).to be_a Hash
      expect(success_message[:success]).to eq('Favorite added successfully.')
      check_hash_structure(success_message, :success, String)
    end

    it 'handles api_key authentication errors' do 
      favorite_params = {
        "api_key": 'jgn983hy48thw9begh98h4539h4',
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }

      post '/api/v1/favorites', params: favorite_params, headers: @headers, as: :json

      expect(response).to_not be_successful
      
      error = JSON.parse(response.body, symbolize_names: true)
      
      check_hash_structure(error, :error, Hash)
      check_hash_structure(error[:error], :status, Integer)
      check_hash_structure(error[:error], :message, String)

      error_attributes = error[:error]
      expect(error_attributes[:status]).to eq(401)
      expect(error_attributes[:message]).to eq("Bad credentials. Try again.")
    end
  end

  describe 'favorite index' do 
    it 'get request with valid api key returns favorites' do 
      create_list(:favorite, 5, user: @user)

      get "/api/v1/favorites?api_key=#{@user.api_key}", headers: @headers, as: :json
      
      expect(response).to be_successful
      
      favorites = JSON.parse(response.body, symbolize_names: true) 
      
      check_hash_structure(favorites, :data, Array)
      
      favorited = favorites[:data]
      
      favorited.each do |favorite|
        check_hash_structure(favorite, :id, String)
        check_hash_structure(favorite, :type, String)
        expect(favorite[:type]).to eq('favorite')
        check_hash_structure(favorite, :attributes, Hash)
        check_hash_structure(favorite[:attributes], :recipe_title, String)
        check_hash_structure(favorite[:attributes], :recipe_link, String)
        check_hash_structure(favorite[:attributes], :country, String)
        check_hash_structure(favorite[:attributes], :created_at, String)
      end
    end
    
    it 'get request without valid api key returns error' do 
      create_list(:favorite, 5, user: @user)

      get '/api/v1/favorites?api_key=gh98h4539h4', headers: @headers, as: :json

      expect(response).to_not be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error, :error, Hash)
      check_hash_structure(error[:error], :status, Integer)
      check_hash_structure(error[:error], :message, String)

      error_attributes = error[:error]
      expect(error_attributes[:status]).to eq(401)
      expect(error_attributes[:message]).to eq("Bad credentials. Try again.")
    end

    it 'returns empty array if no favorites' do 
      get "/api/v1/favorites?api_key=#{@user.api_key}", headers: @headers, as: :json
      
      expect(response).to be_successful
      
      favorites = JSON.parse(response.body, symbolize_names: true) 
      
      check_hash_structure(favorites, :data, Array)

      expect(favorites[:data]).to be_empty
    end
  end
end


