class VideosService
  class << self
    def endpoint(country)
      response = conn.get("search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw") do |request|
        request.params[:q] = country
        request.params[:key] = ENV['youtube_key']
      end
      parse_response(response)
    end

    private 

    def conn 
      Faraday.new("https://youtube.googleapis.com/youtube/v3/")
    end
    
    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end