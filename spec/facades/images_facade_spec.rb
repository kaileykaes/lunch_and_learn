require 'rails_helper'

RSpec.describe ImagesFacade do
  before(:each) do
    @if = ImagesFacade.new
  end

  describe 'initialize' do
    it 'exists' do 
      expect(@if).to be_an ImagesFacade
    end
  end

  describe 'methods' do 
    it 'videos_search' do 
      images = @if.images_search('libya')

      expect(images).to be_an Array

      images.each do |image|
        expect(image).to be_an Image
        expect(image.alt_tag).to be_a String
        expect(image.url).to be_a String
      end
    end
  end
end