require 'rails_helper'

RSpec.describe VideosService do
  describe 'class methods' do
    it 'endpoint' do 
      result = VideosService.endpoint('croatia')

      expect(result).to be_a Hash
      check_hash_structure(result, :kind, String)
      check_hash_structure(result, :etag, String)
      check_hash_structure(result, :nextPageToken, String)
      check_hash_structure(result, :regionCode, String)
      check_hash_structure(result, :pageInfo, Hash)
      check_hash_structure(result, :items, Array)

      videos = result[:items]

      videos.each do |video|
        check_hash_structure(video, :kind, String)
        check_hash_structure(video, :etag, String)
        check_hash_structure(video, :id, Hash)
        check_hash_structure(video[:id], :kind, String)
        check_hash_structure(video[:id], :videoId, String)
        check_hash_structure(video, :snippet, Hash)
        check_hash_structure(video[:snippet], :title, String)
      end
    end
  end
end