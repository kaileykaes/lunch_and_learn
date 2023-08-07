require 'rails_helper'

RSpec.describe 'Learning Resource Serializer', :vcr do
  before(:each) do
    @video = VideosFacade.new.videos_search('peru').sample
    @images = ImagesFacade.new.images_search('peru')
  end

  describe 'serialization' do
    it 'serializes learning resources' do 
      serialized_resource = LearningResourceSerializer.format_resources(@video, @images, 'peru')

      resource = JSON.parse(serialized_resource, symbolize_names: true)
      check_hash_structure(resource, :data, Hash)

      resource_data = resource[:data]

      expect(resource_data).to be_a Hash
      expect(resource_data).to have_key(:id)
      expect(resource_data[:id]).to eq(nil)
      check_hash_structure(resource_data, :type, String)
      expect(resource_data[:type]).to eq('learning_resource')
      check_hash_structure(resource_data, :attributes, Hash)\

      resource_attributes = resource_data[:attributes]

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
  end
end