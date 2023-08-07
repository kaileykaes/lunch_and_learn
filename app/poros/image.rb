class Image
  attr_reader :alt_tag, 
              :url
  
  def initialize(attributes)
    @alt_tag = "#{attributes[:description]}; #{attributes[:alt_description]}"
    @url = attributes[:urls][:raw]
  end
end