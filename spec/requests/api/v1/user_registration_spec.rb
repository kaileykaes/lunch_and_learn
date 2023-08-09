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
      user_count = User.count

      post '/api/v1/users', headers: @headers, params: @user_info, as: :json
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(User.count).to eq(user_count + 1)

      user = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(user, :data, Hash)
      check_hash_structure(user[:data], :type, String)
      check_hash_structure(user[:data], :id, String)
      check_hash_structure(user[:data], :attributes, Hash)
      check_hash_structure(user[:data][:attributes], :name, String)
      check_hash_structure(user[:data][:attributes], :email, String)
      check_hash_structure(user[:data][:attributes], :api_key, String)

      expect(user[:data][:attributes][:name]).to eq('George')
      expect(user[:data][:attributes][:email]).to eq('george@mosquito.org')
    end
  end

  describe 'sad paths' do 
    it 'throws error if email isnt unique' do 
      create(:user, email: 'george@mosquito.org')
      user_count = User.count

      post '/api/v1/users', headers: @headers, params: @user_info, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(403)
      expect(user_count).to eq(user_count)

      error = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error, :error, Hash)
      check_hash_structure(error[:error], :status, Integer)
      check_hash_structure(error[:error], :message, String)

      error_attributes = error[:error]
      expect(error_attributes[:status]).to eq(403)
      expect(error_attributes[:message]).to eq('Validation failed: Email has already been taken')
    end

    it 'throws error if passwords dont match' do 
      user_params = {
        name: "George",
        email: 'george@mosquito.org',
        password: 'test',
        password_confirmation: 'check'
      }

      user_count = User.count

      post '/api/v1/users', headers: @headers, params: user_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(403)
      expect(user_count).to eq(user_count)

      error = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error, :error, Hash)
      check_hash_structure(error[:error], :status, Integer)
      check_hash_structure(error[:error], :message, String)

      error_attributes = error[:error]
      expect(error_attributes[:status]).to eq(403)
      expect(error_attributes[:message]).to eq("Validation failed: Password confirmation doesn't match Password")
    end
  end
end