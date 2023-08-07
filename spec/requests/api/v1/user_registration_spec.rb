require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  before(:each) do
    @headers = { 
      "CONTENT_TYPE" => "application/json"
    }
    @user_info = {
        name: "George",
        email: 'george@mosquito.org',
        password: 'test',
        password_confirmation: 'test'
    }
  end

  describe 'happy path' do
    it 'creates new user' do 
      post '/api/v1/users', headers: @headers, params: @user_info, as: :json
      expect(response).to be_successful
      expect(response.status).to eq(201)

      user = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(user, :data, Hash)
      check_hash_structure(user[:data], :type, String)
      check_hash_structure(user[:data], :id, Integer)
      check_hash_structure(user[:data], :attributes, Hash)
      check_hash_structure(user[:data][:attributes], :name, String)
      check_hash_structure(user[:data][:attributes], :email, String)
      check_hash_structure(user[:data][:attributes], :api_key, String)

      expect(user[:data][:attributes][:name]).to eq('George')
      expect(user[:data][:attributes][:email]).to eq('george@mosquito.org')

      expect(User.count).to change(User, :count).by(1)
    end
  end
end