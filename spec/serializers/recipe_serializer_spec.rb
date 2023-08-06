require 'rails_helper'

RSpec.describe 'Recipe Serializer' do
  before(:each) do
  end
  
  describe 'serialization', :vcr do
    it 'serializes a collection' do 
      recipes = @rp.recipes_search('sudan')

      serialized_json = RecipeSerializer.new(recipes)

      expect(serialized_json).to be_a Hash
      expect(serialized_json).to have_key(:data)
      expect(serialized_json[:data]).to be_a Array
            
      parsed_recipes = JSON.parse(serialized_json[:data], symbolize_names: true)
      
      parsed_recipes.each do |recipe|
        expect(recipe).to have_key[:id]
        expect(recipe[:id]).to eq('null')
        expect(recipe).to have_key[:type]
        expect(recipe[:type]).to eq('recipe')
        expect(recipe).to have_key[:attributes]
        expect(recipe[:attributes]).to be_a Hash
        
        recipe_attributes = recipe[:attributes]
        
        expect(recipe_attributes).to have_key(:title)
        expect(recipe_attributes).to have_key(:url)
        expect(recipe_attributes).to have_key(:country)
        expect(recipe_attributes[:country]).to eq('Sudan')
        expect(recipe_attributes).to have_key(:image)
      end
    end
    
    it 'serializes one recipe' do 
      recipe_info = File.read('spec/fixtures/recipes/one_recipe.json')
      parsed_info = JSON.parse(recipe_info, symbolize_names: true)
      
      recipe = Recipe.new(parsed_info, 'croatia')
      
      serialized_json = RecipeSerializer.new(recipe)
      
      expect(serialized_json).to be_a Hash
      expect(serialized_json).to have_key(:data)
      expect(serialized_json[:data]).to be_a Hash
      
      recipe_details = JSON.parse(serialized_json[:data], symbolize_names: true)
      
      expect(recipe_details).to have_key[:id]
      expect(recipe_details[:id]).to eq('null')
      expect(recipe_details).to have_key[:type]
      expect(recipe_details[:type]).to eq('recipe')
      expect(recipe_details).to have_key[:attributes]
      expect(recipe_details[:attributes]).to be_a Hash
      
      recipe_attributes = recipe_details[:attributes]

      expect(recipe_attributes).to have_key(:title)
      expect(recipe_attributes).to have_key(:url)
      expect(recipe_attributes).to have_key(:country)
      expect(recipe_attributes[:country]).to eq('Sudan')
      expect(recipe_attributes).to have_key(:image)
    end
  end
end