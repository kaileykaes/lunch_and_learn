require 'rails_helper'

RSpec.describe 'User Serializer' do
  before(:each) do
    @user = User.create!({
      name: 'Jeremonoly', 
      email: 'jer@jer.com', 
      password: 'test', 
      password_confirmation: 'test'        
    })
  end

  describe 'serialization' do
    it 'serializes a user' do 
      serialized_user_info = UserSerializer.new(@user).serializable_hash.to_json

      parsed_user_info = JSON.parse(serialized_user_info, symbolize_names: true)
      check_hash_structure(parsed_user_info, :data, Hash)
      check_hash_structure(parsed_user_info[:data], :type, String)
      check_hash_structure(parsed_user_info[:data], :id, String)
      check_hash_structure(parsed_user_info[:data], :attributes, Hash)

      user_attributes = parsed_user_info[:data][:attributes]

      check_hash_structure(user_attributes, :name, String)
      check_hash_structure(user_attributes, :email, String)
      check_hash_structure(user_attributes, :api_key, String)
      expect(user_attributes).to_not have_key(:password)
    end
  end
end