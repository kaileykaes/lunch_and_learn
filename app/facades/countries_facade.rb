class CountriesFacade
  def all_countries
    (CountriesService.endpoint("all"))
  end

  def random_country_name
    country_names.sample
  end

  private
  def create_countries(countries_info)
    countries_info.map do |country_info|
      Country.new(country_info)
    end
  end

  def country_names
    create_countries(all_countries).map do |country|
      country.common_name
    end
  end
end