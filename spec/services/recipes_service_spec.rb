require 'rails_helper'

RSpec.describe RecipesService do
  describe 'class methods', :vcr do 
    it '#endpoint' do 
      response = RecipesService.endpoint("recipes/v2?type=public", 'lithuania')

      expect(response).to be_a Hash
      expect(response).to have_key(:hits)
      expect(response[:hits]).to be_a Array

      recipes = response[:hits]

      expect(recipes).to be_a Array

      recipes.each do |r|
        expect(r).to have_key(:recipe)
        expect(r[:recipe]).to be_a Hash
        expect(r[:recipe]).to have_key(:label)
        expect(r[:recipe][:label]).to be_a String
        expect(r[:recipe]).to have_key(:url)
        expect(r[:recipe][:url]).to be_a String
        expect(r[:recipe]).to have_key(:image)
        expect(r[:recipe][:image]).to be_a String
      end
    end
  end
end