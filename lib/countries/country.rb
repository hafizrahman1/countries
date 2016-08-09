class Countries::Country
  
  attr_accessor :name, :capital, :region, :altSpellings, :relevance, :region, :subregion, 
                :translations, :population, :latlng, :demonym, :area, :gini, :timezones, 
                :borders, :nativeName, :callingCodes, :topLevelDomain, :alpha2Code, :alpha3Code, 
                :currencies, :languages

  @@all = []

  def initialize(country_hash)
    country_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end
  
  # create country instances from array of countries
  def self.create_from_collection(country_array)
    country_array.each do |country_hash|
    self.new(country_hash)
    end
  end

  # create regions list from all country instances
  def self.create_region_list
    regions = []
    self.all.each do |country|
      regions << country.region
    end
    regions.uniq - ["", nil]
  end
  
  # returns all the country instances
  def self.all
    @@all
  end

  # clear all the country instances
  def self.destroy_all
    @@all.clear
  end

end