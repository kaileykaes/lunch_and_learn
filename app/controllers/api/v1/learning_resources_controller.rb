class Api::V1::LearningResourcesController < ApplicationController
  def index
    country_params
    render json: LearningResourceSerializer.format_resources(video, images, params[:country])
  end

  private
  def video
    VideosFacade.new.videos_search(params[:country]).sample
  end

  def images
    ImagesFacade.new.images_search(params[:country])
  end
end