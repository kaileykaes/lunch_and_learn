class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by(email: params[:email]) 
    if user != nil && user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      authentication_fail
    end
  end
end