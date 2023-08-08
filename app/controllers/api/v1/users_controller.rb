class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    require 'pry'; binding.pry
    response.status = 201
    render json: UserSerializer.new(user).serializable_hash.to_json
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end