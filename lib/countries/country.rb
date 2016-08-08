class Countries::Country
  
  attr_accessor :name, :capital, :region, :altSpellings, :relevance, :region, :subregion, 
                :translations, :population, :latlng, :demonym, :area, :gini, :timezones, 
                :borders, :nativeName, :callingCodes, :topLevelDomain, :alpha2Code, :alpha3Code, 
                :currencies, :languages

  API_URL = 'https://restcountries.eu/rest/v1/all'
  @@all = []

  def initialize(country_hash)
    country_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.region_list
    # go to the API, find the regions countries
    # extract the attributes
    # instantiate a region
    regions = []
    self.create_countries

    self.all.each do |country|
      regions << country.region
    end

    regions.uniq - ["", nil]

  end

  def self.create_countries
    doc = RestClient.get(API_URL)
    country_hash = JSON.parse(doc)
    country_hash.each do |attributes|
      self.new(attributes)
    end
  end

  def self.all
    @@all
  end

end