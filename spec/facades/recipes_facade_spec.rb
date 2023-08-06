require 'rails_helper'

RSpec.describe RecipesFacade, :vcr do
  before(:each) do
    @rp = RecipesFacade.new
  end

  describe 'initialize' do
    it 'exists' do 
      expect(@rp).to be_a RecipesFacade
    end
  end

  describe 'methods' do 
    it 'recipes_search' do
      recipes = @rp.recipes_search('sudan')

      expect(recipes).to be_an Array
      recipes.each do |recipe|
        expect(recipe).to be_a Recipe
        expect(recipe.country).to eq('Sudan')
      end
    end
  end
end