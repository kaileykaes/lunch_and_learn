require 'rails_helper'

RSpec.describe Image do
  before(:each) do
    image_info = File.read("spec/fixtures/images/single_image.json")
    parsed_image_info = JSON.parse(image_info, symbolize_names: true)
    @image = Image.new(parsed_image_info)
  end

  describe 'initialize' do 
    it 'exists' do 
      expect(@image).to be_an Image
    end

    it 'has attributes' do 
      expect(@image.alt_tag).to eq('Arch of Marcus Aurelius with view of Gurgi Mosque; white concrete building near palm trees during daytime')
      expect(@image.url).to eq('https://images.unsplash.com/photo-1588889802078-67ce0634a6a3?ixid=M3w0ODU5MTd8MHwxfHNlYXJjaHwxfHxsaWJ5YXxlbnwwfHx8fDE2OTE0MzU5ODF8MA&ixlib=rb-4.0.3')
    end
  end
end