# Our CLI Controller
class Countries::CLI

  def call
    create_countries
    list_regions
    menu
  end

  def create_countries
    @regions = Countries::Country.region_list
    @all_countries = Countries::Country.all
  end

  def list_regions
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
          puts "Here is the list of countries of #{input_region} region:"
          puts "-----------------------------------------------"

          country_list(input_region)

          puts "-----------------------------------------------"

        elsif input == "list"
          list_regions
        elsif input == "exit"
          goodbye
        else
          puts "Not sure you want, type list or exit."
        end
    end

  end

  def country_list(region)
    #print list of countries

    countries = @all_countries.select do |country|
      country.region == region
    end

    countries.each.with_index(1) do |country, i|
      puts "#{i}. #{country.name}."
    end
  end

  def goodbye
    puts "Thank you for using countries CLI-GEM!!!"
  end


end