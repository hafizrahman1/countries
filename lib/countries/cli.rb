# Our CLI Controller
class Countries::CLI

  def call
    greeting
    store_countries
    world_regions
    menu
  end

  def greeting
    puts ColorizedString["\n >>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< "].blue
    print ColorizedString[" >>>"].blue
    print ColorizedString[" Welcome to the countries CLI-GEM "].red.underline
    print ColorizedString["<<< \n"].blue
    puts ColorizedString[" >>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< \n"].blue    
  end

  def store_countries
    @regions = Countries::Country.region_list
    @all_countries = Countries::Country.all
  end

  def world_regions
    puts " List of regions:".bold.blue
    puts " ----------------".bold
    @regions.each.with_index(1) do |region, i|
      puts " #{i}. #{region}\n".bold.red
    end
  end

  def menu

    input = nil

    while input != "exit"
        puts "\n Enter the number of the region you'd like more info on or type 'list' or 'exit'".bold.cyan
        input = gets.strip.downcase
        
        if input.to_i > 0 && input.to_i <= 5
          input_region = @regions[input.to_i - 1]
          puts " Country name\t-\tCapital\t-\tCurrency".bold.blue
          puts " ------------------------------------------------------------".bold

          country_list(input_region)

          puts " ------------------------------------------------------------".bold

          puts "\nEnter the number of the country for details information".bold.cyan

          new_input = gets.strip.downcase
          if (new_input != "list" || new_input != "exit")
            country_details(input_region, new_input.to_i)
          end

        elsif input == "list"
          world_regions

        elsif input == "exit"
          goodbye
          
        else
          puts "Not sure you want, type 'list' or 'exit'".bold.red
        end
    end

  end

  def country_list(region)
    #print list of countries

    @countries = @all_countries.select do |country|
      country.region == region
    end

    @countries.each.with_index(1) do |country, i|

      if (Money::Currency.find(country.currencies[0]))
        puts " #{i}. #{country.name} - #{country.capital} - #{Money::Currency.find(country.currencies[0]).name} (#{country.currencies[0]})".bold.green
      else
        puts " #{i}. #{country.name} - #{country.capital} - (#{country.currencies[0]})".bold.green
      end

    end
  end

  def country_details(region, input)
    country = @countries[input - 1]

    puts "\n Country Name - Capital - Currency - Population - Region - Calling Codes - Languages".bold.blue
    puts " -----------------------------------------------------------------------------------"
    puts " #{country.name} - #{country.capital} - #{country.currencies[0]} - #{country.population} - #{region} - +#{country.callingCodes[0]} - #{country.languages[0]}".bold.green
    puts " -----------------------------------------------------------------------------------\n"
  end

  def goodbye

    puts "\n Thank you for using countries CLI-GEM!\n".bold.red
  end


end