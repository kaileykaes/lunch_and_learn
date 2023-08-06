class Api::V1::RecipesController < ApplicationController

  def index
    response = recipes_facade.recipes_search(params[:country])
    render json: RecipeSerializer.new(response)
  end

  private

  def recipes_facade
    RecipesFacade.new
  end
end