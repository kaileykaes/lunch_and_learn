class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response

  def invalid_record_response(error)
    render json: ErrorSerializer.serialize_error(error, 403)
    response.status = 403
  end

  def authentication_fail
    render json: ErrorSerializer.serialize_error(create_error, 401)
    response.status = 403
  end

  def country_params
    unless params[:country].present? 
      params[:country] = CountriesFacade.new.random_country_name
    end
  end

  private
  def create_error
    error = NameError.new("Bad credentials. Try again.")
  end
end
