class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key]) 
    if user != nil 
      response.status = 201
      render json: success_message
    else
      authentication_fail
    end
  end

  private
  def success_message
    {
      success: "Favorite added successfully."
    }
  end
end