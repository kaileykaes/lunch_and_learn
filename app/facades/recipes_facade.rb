class RecipesFacade
  def recipes_search(country)
    response = RecipesService.endpoint("recipes/v2?type=public", country)
    create_recipes(response[:hits], country)
  end

  private

  def create_recipes(recipes_info, search)
    recipes_info.map do |recipe_info|
      Recipe.new(recipe_info, search)
    end
  end
end