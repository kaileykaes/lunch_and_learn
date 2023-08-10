class Api::V1::UsersController < Api::V1::BaseController
  def create
    response.status = 201
    render json: UserSerializer.new(User.create!(user_params)).serializable_hash.to_json
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end