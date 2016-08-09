class Data

  API_URL = 'https://restcountries.eu/rest/v1/all'

  def self.get_countries
    doc = RestClient.get(API_URL)
    country_array = JSON.parse(doc)
    Country.create_from_collection(country_array)
  end



end