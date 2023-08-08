class CountriesFacade
  def all_countries
    CountriesService.endpoint("all")
  end

  def one_country(country_name)
    create_countries(CountriesService.endpoint("name/#{country_name}")).first
  end

  def random_country_name
    country_names.sample.delete(' ')
  end

  def capital_by_country(country)
    one_country(country).capital
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