class Recipe
  attr_reader :title, 
              :url, 
              :image, 
              :country, 
              :id
  
  def initialize(attributes, country)
    @title = attributes[:recipe][:label]
    @url = attributes[:recipe][:url]
    @image = attributes[:recipe][:image]
    @country = country.capitalize
    @id = nil.to_json
  end
end