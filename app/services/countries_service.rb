class CountriesService
  class << self 
    def endpoint(path)
      parse_response(conn.get(path))
    end
    
    private 

    def conn 
      Faraday.new("https://restcountries.com/v3.1/")
    end
    
    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end

