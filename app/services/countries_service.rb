class CountriesService
  class << self 
    def all_countries
      parse_response(conn.get("all"))
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

