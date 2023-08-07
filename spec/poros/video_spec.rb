require 'rails_helper'

RSpec.describe Video do
  before(:each) do
    info = File.read("spec/fixtures/videos/single_video.json")
    video_data = JSON.parse(info, symbolize_names: true)
    @video = Video.new(video_data)
  end

  describe 'initialize' do
    it 'exists' do 
      expect(@video).to be_a Video
    end

    it 'has attributes' do 
      expect(@video.title).to eq("A Super Quick History of Croatia")
      expect(@video.id).to eq("GXww65SCZ1s")
    end
  end
end