class RecipesService
  class << self 
    def endpoint(path, query)
      response = conn.get(path) do |request|
        request.params[:q] = search
        request.params[:app_id] = ENV['api_id']
        request.params[:app_key] = ENV['api_key']
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