class ImagesService
  class << self 
    def endpoint(path, query)
      response = conn.get(path) do |request|
        request.params[:query] = query
        request.headers['Accept-Version'] = 'v1'
        request.params[:client_id] = ENV['unsplash_access_key']
      end
      parse_response(response)
    end
    
    private 
    def conn 
      Faraday.new("https://api.unsplash.com/")
    end
    
    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end