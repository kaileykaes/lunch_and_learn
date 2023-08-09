require 'rails_helper'

RSpec.describe VideosFacade, :vcr do
  before(:each) do
    @vf = VideosFacade.new
  end

  describe 'initialize' do
    it 'exists' do 
      expect(@vf).to be_a VideosFacade
    end
  end

  describe 'methods' do 
    it 'videos_search' do 
      videos = @vf.videos_search('congo')

      expect(videos).to be_an Array

      videos.each do |video|
        expect(video).to be_a Video
        expect(video.title).to be_a String
        expect(video.youtube_video_id).to be_a String
      end
    end
  end
end