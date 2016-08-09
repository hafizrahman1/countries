class Table 
  extend CommandLineReporter

  def self.display_as_table(countries)
    vertical_spacing 2 # number of blank lines to output

    table :border => true do
      row :color =>'green' do
        column '', :width => 3
        column 'Country name', :width => 30, :bold => true, :align => 'center'
        column 'Capital',      :width => 30, :bold => true, :align => 'center'
        column 'Currency',     :width => 30, :bold => true, :align => 'center'
      end

      countries.each.with_index(1) do |country, index|
        currency = get_currency(country.currencies[0])
        row :color => 'yellow', :bold => true do
          column index
          column country.name, :color => 'red'
          column country.capital, :color => 'cyan'
          column currency, :color => 'blue'
        end
      end
    end
    vertical_spacing 2
  end
  
  # display country details summary
  def self.display_as_summary(country)
    languages = get_languange(country.languages).join(", ")
    currency = get_currency(country.currencies[0])
    
    if !(country.borders.empty?)
      borders = get_countries(country.borders).join(", ")
    else
      borders = "Information not available!"
    end

    if !(country.timezones == nil)
      timezones = country.timezones.join(",")
    else
      timezones = "Information not available!"
    end

    #header :title => "Summary details about #{country.name}:".bold.red, :width => 140, :align => 'center', :rule => true, :bold => true, :timestamp => false
    puts "\n==============================================================================================================================================".bold.blue
    puts "\t\t\t\t\t\tSummary details about #{country.name}:".bold.red
    puts "==============================================================================================================================================\n".bold.blue
    puts "\tCountry name : #{country.name}".bold.green
    puts "\tCapital      : #{country.capital}".bold.green
    puts "\tCurrency     : #{currency} (#{country.currencies[0]})".bold.green
    puts "\tLanguage     : #{languages}".bold.green
    puts "\tRegion       : #{country.region}".bold.green
    puts "\tSub-region   : #{country.subregion}".bold.green
    puts "\tPopulation   : #{country.population.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}".bold.green
    puts "\tLatitude     : #{country.latlng[0]}".bold.green
    puts "\tLongitude    : #{country.latlng[1]}".bold.green
    puts "\tBorders      : #{borders}".bold.green
    puts "\tArea         : #{country.area}".bold.green
    puts "\tTimezones    : #{timezones}".bold.green
    puts "\tCountry Code : +#{country.callingCodes.first}".bold.green
    puts "\n==============================================================================================================================================\n".bold.blue


  end

  # Get the correct currency name from currency symbol
  def self.get_currency(currency_symbol)
    if Money::Currency.find(currency_symbol)
      Money::Currency.find(currency_symbol).name
    else
      currency_symbol
    end
  end
  
  # Get the correct country name array from alpha3Codes array
  def self.get_countries(country_code_array)
    countries = []
    country_code_array.each do |country_code|
      if IsoCountryCodes.find(country_code)
        countries << IsoCountryCodes.find(country_code).name
      end
    end
    countries
  end

  # Get the correct language from language symbol
  def self.get_languange(language_array)
    languages = []
    language_array.each do |language_symbol|
      if I18nData.languages.include?(language_symbol.upcase)
        languages << I18nData.languages[language_symbol.upcase]
      end
    end
    languages
  end
end