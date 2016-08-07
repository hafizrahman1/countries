# Our CLI Controller
class Countries::CLI

  def call
    store_countries
    world_regions
    menu
  end

  def store_countries
    @regions = Countries::Country.region_list
    @all_countries = Countries::Country.all
  end

  def world_regions
    puts "List of regions:"
    puts "----------------"
    @regions.each.with_index(1) do |region, i|
      puts "#{i}. #{region}"
    end
  end

  def menu

    input = nil

    while input != "exit"
        puts "Enter the number of the region you'd like more info on or type list again or type exit:"
        input = gets.strip.downcase
        
        if input.to_i > 0 && input.to_i <= 5
          input_region = @regions[input.to_i - 1]
          puts "#{input_region} region's list of countries, their capital and currency:"
          puts "------------------------------------------------------------"

          country_list(input_region)

          puts "------------------------------------------------------------"

          puts "Enter the number of the country for details information of that country: "

          new_input = gets.strip.downcase
          if (new_input != "list" || new_input != "exit")
            country_details(input_region, new_input.to_i)
          end

        elsif input == "list"
          world_regions
        elsif input == "exit"
          goodbye
        else
          puts "Not sure you want, type list or exit."
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
        puts "#{i}. #{country.name} - #{country.capital} - #{Money::Currency.find(country.currencies[0]).name} (#{country.currencies[0]})"
      else
        puts "#{i}. #{country.name} - #{country.capital} - (#{country.currencies[0]})"
      end

    end
  end

  def country_details(region, input)
    country = @countries[input - 1]

    puts "Country Name - Capital - Currency - Population - Region - Calling Codes - Languages"
    puts "-----------------------------------------------------------------------------------"
    puts "#{country.name} - #{country.capital} - #{country.currencies[0]} - #{country.population} - #{region} - +#{country.callingCodes[0]} - #{country.languages[0]}"
    puts "-----------------------------------------------------------------------------------"
    binding.pry
  end

  def goodbye
    puts "Thank you for using countries GEM!"
  end


end