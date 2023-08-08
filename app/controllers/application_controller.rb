class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response

  def invalid_record_response(error)
    require 'pry'; binding.pry

    render json: ErrorSerializer.new(error).serialize_json, status: 403
  end
end
