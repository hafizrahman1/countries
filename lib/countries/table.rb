class Table 
  extend CommandLineReporter

  def self.display_as_table(countries)
    vertical_spacing 2 # number of blank lines to output

    table :border => true do
      row :color =>'green' do
        column '', :width => 2
        column 'Country name', :width => 30, :bold => true, :align => 'center'
        column 'Capital',      :width => 30, :bold => true, :align => 'center'
        column 'Currency',     :width => 30, :bold => true, :align => 'center'
      end

      countries.each.with_index(1) do |country, index|
        currency = get_currency(country.currencies[0])
        row :color => 'yellow' do
          column index
          column country.name, :color => 'red'
          column country.capital, :color => 'cyan'
          column currency, :color => 'blue'
        end
      end
    end
    vertical_spacing 2
  end

  def self.display_as_summary(country)
    languages = get_languange(country.languages).join(",")
    currency = get_currency(country.currencies[0])
    
    if !(country.borders.empty?)
      borders = get_countries(country.borders).join(",")
    else
      borders = ""
    end

    if !(country.timezones == nil)
      timezones = country.timezones.join(",")
    else
      timezones = ""
    end

    # country.borders.select do|country_code|
    #   h = get_countries(country_code)
    #   binding.pry
    # end

    puts "\nSummary details about #{country.name}:".bold.red
    puts "=============================\n".bold.blue
    puts "Country name : #{country.name}"
    puts "Capital      : #{country.capital}"
    puts "Currency     : #{currency} (#{country.currencies[0]})"
    puts "Language     : #{languages}"
    puts "Region       : #{country.region}"
    puts "Sub-region   : #{country.subregion}"
    puts "Population   : #{country.population}"
    puts "Latitude     : #{country.latlng[0]}"
    puts "Longitude    : #{country.latlng[1]}"
    puts "Borders      : #{borders}"
    puts "Area         : #{country.area}"
    puts "Timezones    : #{timezones}"
    puts "Country Code : +#{country.callingCodes.first}"
    # puts "Top Domain  : #{country.topLevelDomain.join(",")}"
    puts "=============================\n".bold.blue

  end

  # Get the correct currency name from currency symbol
  def self.get_currency(currency_symbol)

    if Money::Currency.find(currency_symbol)
      Money::Currency.find(currency_symbol).name
    else
      currency_symbol
    end

  end

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
    # language = I18nData.languages.select do |key, value|
    #   key == language_symbol.upcase
    # end
    # language.last
  end
end