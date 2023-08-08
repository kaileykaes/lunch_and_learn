require 'rails_helper'

RSpec.describe 'Favorite Serializer' do
  before(:each) do
    @user = create(:user)
    create_list(:favorite, 3, user: @user)
  end

  describe 'relationships' do
    it 'serializes collection' do 
      favorites = Favorite.where(user: @user)
      serialized = FavoriteSerializer.new(favorites, is_collection: true).serializable_hash.to_json

      parsed = JSON.parse(serialized, symbolize_names: true)
      
      check_hash_structure(parsed, :data, Array)
      
      favorited = parsed[:data]
      
      favorited.each do |favorite|
        check_hash_structure(favorite, :id, Integer)
        check_hash_structure(favorite, :type, String)
        expect(favorite[:type]).to eq('favorite')
        check_hash_structure(favorite, :attributes, Hash)
        check_hash_structure(favorite[:attributes], :recipe_title, String)
        check_hash_structure(favorite[:attributes], :recipe_link, String)
        check_hash_structure(favorite[:attributes], :country, String)
        check_hash_structure(favorite[:attributes], :created_at, DateTime)
      end
    end
    
    it 'serializes a single favorite' do 
      favorite = Favorite.first
      serialized = FavoriteSerializer.new(favorites, is_collection: true).serializable_hash.to_json
      
      parsed = JSON.parse(serialized, symbolize_names: true)
      check_hash_structure(parsed, :data, Hash)
      
      check_hash_structure(parsed, :id, Integer)
      check_hash_structure(parsed, :type, String)
      expect(parsed[:type]).to eq('favorite')
      check_hash_structure(parsed, :attributes, Hash)
      check_hash_structure(parsed[:attributes], :recipe_title, String)
      check_hash_structure(parsed[:attributes], :recipe_link, String)
      check_hash_structure(parsed[:attributes], :country, String)
      check_hash_structure(parsed[:attributes], :created_at, DateTime)
    end
  end
end