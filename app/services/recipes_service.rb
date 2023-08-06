class RecipesService
  class << self 
    def endpoint(path, query)
      response = conn.get(path) do |request|
        request.params[:q] = query
        request.params[:app_id] = ENV['app_id']
        request.params[:app_key] = ENV['app_key']
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
end