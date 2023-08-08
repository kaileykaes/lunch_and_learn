require 'rails_helper'

RSpec.describe 'Learning Resources Requests' do
  describe 'endpoint' do
    it 'hits the endpoint' do 
      headers = { "CONTENT_TYPE" => "application/json"} 
      get "/api/v1/learning_resources?country=india", headers: headers
      expect(response).to be_successful
    end
    
    it 'returns serialized json', :vcr do 
      headers = { "CONTENT_TYPE" => "application/json"}
      get "/api/v1/learning_resources?country=india", headers: headers
      learning_resource = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(learning_resource, :data, Hash)

      learning_resource_data = learning_resource[:data]

      expect(learning_resource_data).to be_a Hash
      expect(learning_resource_data).to have_key(:id)
      expect(learning_resource_data[:id]).to eq(nil)
      check_hash_structure(learning_resource_data, :type, String)
      expect(learning_resource_data[:type]).to eq('learning_resource')
      check_hash_structure(learning_resource_data, :attributes, Hash)\

      resource_attributes = learning_resource_data[:attributes]

      check_hash_structure(resource_attributes, :country, String)
      check_hash_structure(resource_attributes, :video, Hash)
      check_hash_structure(resource_attributes, :images, Array)
      
      video = resource_attributes[:video]

      check_hash_structure(video, :title, String)
      check_hash_structure(video, :youtube_video_id, String)
      
      images = resource_attributes[:images]

      images.each do |image|
        check_hash_structure(image, :alt_tag, String)
        check_hash_structure(image, :url, String)
      end
    end

    it 'returns complete serialized json if no country given' do 
      headers = { "CONTENT_TYPE" => "application/json"}
      get "/api/v1/learning_resources", headers: headers
      learning_resource = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(learning_resource, :data, Hash)

      learning_resource_data = learning_resource[:data]

      expect(learning_resource_data).to be_a Hash
      expect(learning_resource_data).to have_key(:id)
      expect(learning_resource_data[:id]).to eq(nil)
      check_hash_structure(learning_resource_data, :type, String)
      expect(learning_resource_data[:type]).to eq('learning_resource')
      check_hash_structure(learning_resource_data, :attributes, Hash)\

      resource_attributes = learning_resource_data[:attributes]

      check_hash_structure(resource_attributes, :country, String)
      expect(resource_attributes[:country]).to_not be nil

      check_hash_structure(resource_attributes, :video, Hash)
      check_hash_structure(resource_attributes, :images, Array)
      
      video = resource_attributes[:video]

      check_hash_structure(video, :title, String)
      check_hash_structure(video, :youtube_video_id, String)
      
      images = resource_attributes[:images]

      images.each do |image|
        check_hash_structure(image, :alt_tag, String)
        check_hash_structure(image, :url, String)
      end
    end
  end
end