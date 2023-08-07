class LearningResourceSerializer
  class << self
    def format_resources(video, images, country)
      { 
        data: {
          id: nil, 
          type: 'learning_resource', 
          attributes: {
            country: country, 
            video: video_serialization(video), 
            images: images_format(images)
          }
        }
      }.to_json
    end

    private
    def images_format(images)
      images.map do |image|
        {
          alt_tag: image.alt_tag, 
          url: image.url
        }
      end
    end

    def video_serialization(video)
      if video == nil
        {}
      else
        {
          title: video.title, 
          youtube_video_id: video.youtube_video_id
        }
      end
    end
  end
end