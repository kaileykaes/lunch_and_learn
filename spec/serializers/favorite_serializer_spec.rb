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
    
    it 'serializes a single favorite' do 
      favorite = Favorite.first
      serialized = FavoriteSerializer.new(favorite).serializable_hash.to_json

      parsed = JSON.parse(serialized, symbolize_names: true)
      check_hash_structure(parsed, :data, Hash)

      single_favorite = parsed[:data]
      
      check_hash_structure(single_favorite, :id, String)
      check_hash_structure(single_favorite, :type, String)
      expect(single_favorite[:type]).to eq('favorite')
      check_hash_structure(single_favorite, :attributes, Hash)
      check_hash_structure(single_favorite[:attributes], :recipe_title, String)
      check_hash_structure(single_favorite[:attributes], :recipe_link, String)
      check_hash_structure(single_favorite[:attributes], :country, String)
      check_hash_structure(single_favorite[:attributes], :created_at, String)
    end
  end
end