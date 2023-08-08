class Api::V1::SessionsController < ApplicationController
  def create
    if found_user != nil && found_user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      authentication_fail
    end
  end

  private 
  def found_user
    User.find_by(email: params[:email]) 
  end
end