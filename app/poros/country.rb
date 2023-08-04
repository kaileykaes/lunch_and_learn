class Country
  attr_reader :common_name, 
              :official_name, 
              :capital
  
  def initialize(attributes)
    @common_name = attributes[:name][:common]
    @official_name = attributes[:name][:official]
    @capital = attributes[:capital].first
  end
end