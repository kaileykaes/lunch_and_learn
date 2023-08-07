class VideosFacade
  def videos_search(country)
    response = VideosService.endpoint(country)
    videos = retained_videos(response[:items])
    create_videos(videos)
  end

  private 
  def create_videos(videos_info)
    videos_info.map do |video_info|
      if video_info[:id].has_key?(:videoId)
        Video.new(video_info)
      end
    end
  end

  def retained_videos(infos)
    infos.find_all do |info|
      info[:id].has_key?(:videoId)
    end
  end
end