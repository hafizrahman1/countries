# Our CLI Controller
class Countries::CLI

  def call
    greeting
    store_countries
    world_regions
    menu
    goodbye
  end

  def greeting
    puts "\n >>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< ".blue
    print " >>>".blue
    print " Welcome to the countries CLI-GEM ".bold.red
    print "<<< \n".blue
    puts " >>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< \n".blue    
  end

  def store_countries
    @regions = Countries::Country.region_list
    @all_countries = Countries::Country.all
  end

  def world_regions
    puts " List of regions:".bold.blue
    # puts " ----------------".bold
    @regions.each.with_index(1) do |region, i|
      puts " #{i}. #{region}".bold.red
    end
  end

  def menu

    input = nil
    status = false

    until status == true
        puts "\n Enter the number of the region you'd like to get more info on or type 'list' or 'exit':".bold.cyan
        input = digit_or_letter

        case input

        when 1..@regions.size
          input_region = @regions[input.to_i - 1]
          #header :title => "Country name\t - \t Capital\t - \t Currency", :width => 80, :align => 'center', :rule => true, :bold => false, :timestamp => true
          # puts " Country name\t-\tCapital\t-\tCurrency".bold.blue
          # puts " ------------------------------------------------------------".bold

          country_list(input_region)

          # For specific country information from the list of countries
          new_input = nil
          while new_input != "exit"
            puts "\nEnter the country number to get more information or type 'exit':".bold.cyan
            new_input = digit_or_letter
            
            case new_input

            when (1..@countries.size)
              country_details(input_region, new_input.to_i)
            # when "list"
            #   country_list(input_region)
            when "exit"
              break
            else
              puts "Please enter a valid input, 1-#{@countries.size}, 'list' or 'exit':"
            end
          end

        when "list"
          world_regions

        when "exit"
          status = true

        else
          puts "Please enter a valid input, 1-#{@regions.size}, 'list' or 'exit':".bold.red
        end
    end

  end

  def country_list(region)
    #print list of countries
    @countries = @all_countries.select do |country|
      country.region == region
    end

    system "clear"
    puts "List of countries of the #{region} region:".bold.red
    puts "\n========Country name=========Capital==========Currency".bold.blue
    # puts " ------------------------------------------------------------".bold
    @countries.each.with_index(1) do |country, i|

      puts " #{i}. #{country.name} - #{country.capital} - #{get_currency(country.currencies[0])} (#{country.currencies[0]})".bold.green

    end
    puts "================================================================\n".bold.blue
  end

  def country_details(region, input)
    country = @countries[input - 1]
    language = get_languange(country.languages[0])
    currency = get_currency(country.currencies[0])

    # if Money::Currency.find(country.currencies[0]).name

    puts "\n Country Name - Capital - Currency - Population - Region - Calling Codes - Languages".bold.blue
    puts " -----------------------------------------------------------------------------------"
    puts " #{country.name} - #{country.capital} - #{currency} - #{country.population} - #{region} - +#{country.callingCodes[0]} - #{language}".bold.green
    puts " -----------------------------------------------------------------------------------\n"

  end

  # Get the correct language from language symbol
  def get_languange(language_symbol)
    language = I18nData.languages.detect do |key, value|
      key == language_symbol.upcase
    end
    language.last
  end
 
  # Get the correct currency name from currency symbol
  def get_currency(currency_symbol)

    if Money::Currency.find(currency_symbol)
      Money::Currency.find(currency_symbol).name
    else
      currency_symbol
    end

  end

  def digit_or_letter
    input = gets.strip.downcase
    input.match(/\d+/).to_s.to_i == 0 ? input : input.to_i 
  end

  def goodbye
    puts "\n Thank you for using countries CLI-GEM!\n".bold.red
  end


end