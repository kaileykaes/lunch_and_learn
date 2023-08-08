class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response

  def invalid_record_response(error)
    render json: ErrorSerializer.serialize_error(error, 403)
    response.status = 403
  end
end
