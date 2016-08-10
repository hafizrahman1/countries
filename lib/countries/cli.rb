# Our CLI Controller
class Countries::CLI

  def run
    greetings
    store_countries
    list_regions
    menu
    goodbye
  end
  
  # welcome greetings
  def greetings
    puts "\n>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< ".blue
    print ">>>".blue
    print "Welcome to the countries cli-gem!".bold.red
    print "<<< \n".blue
    puts ">>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< \n".blue    
  end
 
 # store the countries information and create region list
  def store_countries
    Countries::Data.get_data
    @regions = Countries::Country.create_region_list
  end

 # list total regions
  def list_regions
    puts "List of regions:\n".bold.underline.blue
    @regions.each.with_index(1) do |region, i|
      puts "#{i}. #{region}".bold.red
    end
  end

  def menu

    input = nil
    status = false

    until status == true
        puts "\nEnter the region number (1-#{@regions.size}) to get list of countries or type 'list' or 'exit':".bold.cyan
        input = digit_or_word

        case input

        when 1..@regions.size
          input_region = @regions[input.to_i - 1]
          country_list_by_region(input_region)

          selected_country(input_region)
          break

        when "list"
          Countries::Country.destroy_all
          list_regions

        when "exit"
          status = true

        else
          puts "\nPlease enter a valid input, 1-#{@regions.size} or type 'list' or 'exit':".bold.red
        end
    end

  end

  # get the selected country information from the list of countries
  def selected_country(input_region)

    new_input = nil
    
    while new_input != "exit"
      puts "\nEnter the country number (1-#{@countries.size}) to get more information or type 'back' or 'list' or 'exit':".bold.cyan
      new_input = digit_or_word
      
      case new_input

      when (1..@countries.size)
        country_details(input_region, new_input.to_i)

      when "list"
        country_list_by_region(input_region)
      
      when "back"
        menu
        break

      when "exit"
        break

      else
        puts "\nPlease enter a valid input, 1-#{@countries.size} or type 'list' or 'exit':".bold.red
      end
    end
  end

  # get the country list of given region
  def country_list_by_region(region)
    # select list of countries based on the region
    @countries = Countries::Country.all.select do |country|
      country.region == region
    end
    # print the list of countries as table format
    Table.display_as_table(@countries)
  end
  
  # country details based on region and country
  def country_details(region, input)
    country = @countries[input - 1]
    Table.display_as_summary(country)
    puts "\nWould you like to browse online to see more about #{country.name}? 'yes' or 'no':".bold.cyan
    input = digit_or_word

    if input == "yes"
      #new_link = "http://www.worldbank.org/en/country/#{country.name.downcase}"
      link = "https://www.cia.gov/library/publications/the-world-factbook/geos/#{country.alpha2Code.downcase}.html"
      Launchy.open(link)
    end
  end

  # check the input is a string or fixnum
  def digit_or_word
    input = gets.strip.downcase
    input.match(/\d+/).to_s.to_i == 0 ? input : input.to_i 
  end

  # exit the program
  def goodbye
    puts "\nThank you for using countries cli-gem!\n".bold.red
  end

end