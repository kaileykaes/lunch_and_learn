class Recipe
  attr_reader :title, 
              :url, 
              :image, 
              :country
  
  def initialize(attributes, country)
    @title = attributes[:recipe][:label]
    @url = attributes[:recipe][:url]
    @image = attributes[:recipe][:image]
    @country = country
  end
end