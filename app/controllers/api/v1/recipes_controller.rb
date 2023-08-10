class Api::V1::RecipesController < Api::V1::BaseController
  def index
    settle_country_params
    render json: RecipeSerializer.new(recipes_facade.recipes_search(params[:country]))
  end

  private
  def recipes_facade
    RecipesFacade.new
  end
end