class AirQualityService
  class << self 
    def endpoint(query)
      response = conn.get("/v1/airquality?city=#{query}") do |request|
        request.headers['X-Api-Key'] = ENV['air_quality_key']
      end
      parse_response(response)
    end
    
    private 

    def conn 
      Faraday.new("https://api.api-ninjas.com")
    end
    
    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end