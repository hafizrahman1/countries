class Countries::Data

  API_URL = 'https://restcountries.eu/rest/v1/all'

  # collect information from the API
  def self.get_data
    doc = RestClient.get(API_URL)
    self.parse_data(doc)
  end
  
  # parse the collected data in JSON format
  def self.parse_data(doc)
    country_array = JSON.parse(doc)
    self.get_countries(country_array)
  end
  
  # get country instances using Country class
  def self.get_countries(country_array)
    Countries::Country.create_from_collection(country_array)
  end

end