require 'rails_helper'

RSpec.describe 'Favorites Requests', type: :request do
  before(:each) do 
    @headers = { "CONTENT_TYPE" => "application/json"} 
  end

  describe 'favorite creation' do
    it 'successfully posts a favorite and returns success message' do 
      favorite_params = {
        "api_key": "jgn983hy48thw9begh98h4539h4",
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }
      
      post '/api/v1/favorites', params: favorite_params, headers: @headers, as: :json

      expect(response).to be_successful
      
      success_message = JSON.parse(response.body, symbolize_names: true)

      expect(success_message).to be_a Hash
      expect(success_message[:success]).to eq('Favorite added successfully')
      check_hash_structure(success_message, :success, String)
    end
  end
end


