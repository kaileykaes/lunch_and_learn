require 'rails_helper'

RSpec.describe ImagesService do
  describe 'class methods' do
    it 'endpoint' do 
      result = ImagesService.endpoint("search/photos?page=1", 'libya')

      expect(result).to be_a Hash

      check_hash_structure(result, :total, Integer)
      check_hash_structure(result, :total_pages, Integer)
      check_hash_structure(result, :results, Array)

      results = result[:results].take(5)

      results.each do |r|
        check_hash_structure(r, :id, String)
        check_hash_structure(r, :description, String)
        check_hash_structure(r, :alt_description, String)
        check_hash_structure(r, :urls, Hash)
        check_hash_structure(r[:urls], :raw, String)
        check_hash_structure(r[:urls], :full, String)
        check_hash_structure(r[:urls], :regular, String)
      end
    end
  end
end