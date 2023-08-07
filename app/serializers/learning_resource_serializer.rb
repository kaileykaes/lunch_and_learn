class LearningResourceSerializer
  class << self
    def format_resources(video, images, country)
      { 
        data: {
          id: nil, 
          type: 'learning_resource', 
          attributes: {
            country: country, 
            video: {
              title: video.title, 
              youtube_video_id: video.youtube_video_id
            }, 
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
  end
end