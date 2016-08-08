# Our CLI Controller
class Countries::CLI

  def call
    greeting
    store_countries
    list_regions
    menu
    goodbye
  end

  def greeting
    puts "\n>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< ".blue
    print ">>>".blue
    print "Welcome to the countries cli-gem!".bold.red
    print "<<< \n".blue
    puts ">>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< \n".blue    
  end

  def store_countries
    @regions = Countries::Country.region_list
    @all_countries = Countries::Country.all
  end

  def list_regions
    puts "List of regions:".bold.blue
    # puts " ----------------".bold
    @regions.each.with_index(1) do |region, i|
      puts "#{i}. #{region}".bold.red
    end
  end

  def menu

    input = nil
    status = false

    until status == true
        puts "Enter the number of the region you'd like to get more info on or type 'list' or 'exit':".bold.cyan
        input = digit_or_letter

        case input

        when 1..@regions.size
          input_region = @regions[input.to_i - 1]

          country_list(input_region)

          # For specific country information from the list of countries
          new_input = nil
          while new_input != "exit"
            puts "Enter the country number to get more information or type 'exit':".bold.cyan
            new_input = digit_or_letter
            
            case new_input

            when (1..@countries.size)
              country_details(input_region, new_input.to_i)

            when "list"
              country_list(input_region)
            # when "list-region"
            #   menu
            when "exit"
              break
            else
              puts "Please enter a valid input, 1-#{@countries.size}, 'list' or 'exit':"
            end
          end

        when "list"
          list_regions

        when "exit"
          status = true

        else
          puts "Please enter a valid input, 1-#{@regions.size}, 'list' or 'exit':".bold.red
        end
    end

  end

  def country_list(region)
    # select list of countries based on region
    @countries = @all_countries.select do |country|
      country.region == region
    end
    # print list of countries as table format
    Table.display_as_table(@countries)
  end

  def country_details(region, input)
    country = @countries[input - 1]
    Table.display_as_summary(country)

  end

  # # Get the correct language from language symbol
  # def get_languange(language_symbol)
  #   language = I18nData.languages.detect do |key, value|
  #     key == language_symbol.upcase
  #   end
  #   language.last
  # end
 
  # # Get the correct currency name from currency symbol
  # def get_currency(currency_symbol)

  #   if Money::Currency.find(currency_symbol)
  #     Money::Currency.find(currency_symbol).name
  #   else
  #     currency_symbol
  #   end

  # end

  def digit_or_letter
    input = gets.strip.downcase
    input.match(/\d+/).to_s.to_i == 0 ? input : input.to_i 
  end

  def goodbye
    puts "\nThank you for using countries CLI-GEM!\n".bold.red
  end


end