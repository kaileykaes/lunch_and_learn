class VideosService
  def endpoint(country)
    response = conn.get(path) do |request|
      request.params[:q] = query
      request.params[:key] = ENV['youtube_key']
    end
    parse_response(response)
  end

  private 

  def conn 
    Faraday.new("https://api.edamam.com/api/")
  end
  
  def parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end