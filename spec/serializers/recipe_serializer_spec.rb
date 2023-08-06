require 'rails_helper'

RSpec.describe 'Recipe Serializer' do
  describe 'serialization', :vcr do
    it 'serializes a collection' do 
      recipes = RecipesFacade.new.recipes_search('france')

      serialized_recipes = RecipeSerializer.new(recipes, is_collection: true).serializable_hash.to_json
      expect(serialized_recipes).to be_a String

      parsed_recipes = JSON.parse(serialized_recipes, symbolize_names: true)

      expect(parsed_recipes).to be_a Hash
      expect(parsed_recipes).to have_key(:data)
      expect(parsed_recipes[:data]).to be_a Array
            
      
      parsed_recipes[:data].each do |recipe|
        expect(recipe).to have_key(:id)
        expect(recipe[:id]).to eq('null')
        expect(recipe).to have_key(:type)
        expect(recipe[:type]).to eq('recipe')
        expect(recipe).to have_key(:attributes)
        expect(recipe[:attributes]).to be_a Hash
        
        recipe_attributes = recipe[:attributes]
        
        expect(recipe_attributes).to have_key(:title)
        expect(recipe_attributes).to have_key(:url)
        expect(recipe_attributes).to have_key(:country)
        expect(recipe_attributes[:country]).to eq('France')
        expect(recipe_attributes).to have_key(:image)
      end
    end
    
    it 'serializes one recipe' do 
      recipe_info = File.read('spec/fixtures/recipes/one_recipe.json')
      parsed_info = JSON.parse(recipe_info, symbolize_names: true)
      
      recipe = Recipe.new(parsed_info, 'croatia')
      
      serialized_recipe = RecipeSerializer.new(recipe).serializable_hash.to_json
      
      expect(serialized_recipe).to be_a String

      parsed_recipe = JSON.parse(serialized_recipe, symbolize_names: true)

      expect(parsed_recipe).to be_a Hash
      expect(parsed_recipe).to have_key(:data)
      expect(parsed_recipe[:data]).to be_a Hash
      
      recipe_details = parsed_recipe[:data]

      expect(recipe_details).to have_key(:id)
      expect(recipe_details[:id]).to eq('null')
      expect(recipe_details).to have_key(:type)
      expect(recipe_details[:type]).to eq('recipe')
      expect(recipe_details).to have_key(:attributes)
      expect(recipe_details[:attributes]).to be_a Hash
      
      recipe_attributes = recipe_details[:attributes]

      expect(recipe_attributes).to have_key(:title)
      expect(recipe_attributes).to have_key(:url)
      expect(recipe_attributes).to have_key(:country)
      expect(recipe_attributes[:country]).to eq('Croatia')
      expect(recipe_attributes).to have_key(:image)
    end
  end
end