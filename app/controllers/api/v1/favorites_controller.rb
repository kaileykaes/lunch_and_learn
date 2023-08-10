class Api::V1::FavoritesController < Api::V1::BaseController
  before_action :find_user

  def create
    if @user != nil 
      @user.favorites.create!(favorite_params)
      response.status = 201
      render json: success_message
    else
      authentication_fail
    end
  end

  def index
    if @user != nil 
      render json: FavoriteSerializer.new(@user.favorites, is_collection: true).serializable_hash.to_json 
    else
      authentication_fail
    end
  end

  private
  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end

  def success_message
    {
      success: "Favorite added successfully."
    }
  end

  def find_user
    @user = User.find_by(api_key: params[:api_key])
  end
end