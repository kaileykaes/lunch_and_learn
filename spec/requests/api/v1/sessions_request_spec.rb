require 'rails_helper'

RSpec.describe 'Sessions Requests', type: :request do
  before(:each) do
    @user = create(:user, email: 'something@something.com')
    @headers = { 
      "CONTENT_TYPE" => "application/json"
    }
  end

  describe 'happy path' do
    it 'posts session info, returns user details' do 
      user_session_info = {
        email: @user.email, 
        password: @user.password
      }
      post '/api/v1/sessions', params: user_session_info, headers: @headers, as: :json
      
      expect(response).to be_successful
      
      user_info = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(user_info, :data, Hash)
      check_hash_structure(user_info[:data], :type, String)
      check_hash_structure(user_info[:data], :id, String)
      check_hash_structure(user_info[:data], :attributes, Hash)

      user_attributes = user_info[:data][:attributes]

      check_hash_structure(user_attributes, :name, String)
      check_hash_structure(user_attributes, :email, String)
      check_hash_structure(user_attributes, :api_key, String)
      expect(user_attributes).to_not have_key(:password)

      expect(user_attributes[:name]).to eq(@user.name)
      expect(user_attributes[:email]).to eq(@user.email)
      expect(user_attributes[:api_key]).to eq(@user.api_key)
    end
  end

  describe 'sad paths' do
    it 'bad email, throws error' do 
      user_session_info = {
        email: 'joshuagiraffe@raffi.org', 
        password: @user.password
      }
      post '/api/v1/sessions', params: user_session_info, headers: @headers, as: :json
      
      expect(response).to_not be_successful
      
      error = JSON.parse(response.body, symbolize_names: true)
      
      check_hash_structure(error, :error, Hash)
      check_hash_structure(error[:error], :status, Integer)
      check_hash_structure(error[:error], :message, String)

      error_attributes = error[:error]
      expect(error_attributes[:status]).to eq(401)
      expect(error_attributes[:message]).to eq("Bad credentials. Try again.")
    end

    it 'bad password, throws error' do 
      user_session_info = {
        email: @user.email, 
        password: 'shulem'
      }
      post '/api/v1/sessions', params: user_session_info, headers: @headers, as: :json
      
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
end