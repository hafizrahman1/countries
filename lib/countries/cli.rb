# Our CLI Controller
class Countries::CLI

  def run
    greetings
    list_regions
    menu
    goodbye
  end

  def greetings
    puts "\n>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< ".blue
    print ">>>".blue
    print "Welcome to the countries cli-gem!".bold.red
    print "<<< \n".blue
    puts ">>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<< \n".blue    
  end

  def list_regions
    Countries::Data.get_data
    @regions = Countries::Country.create_region_list
    puts "List of regions:\n".bold.underline.blue
    # puts " ----------------".bold
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

          # For specific country information from the list of countries
          new_input = nil
          while new_input != "exit"
            puts "\nEnter the country number (1-#{@countries.size}) to get more information or type 'exit':".bold.cyan
            new_input = digit_or_word
            
            case new_input

            when (1..@countries.size)
              country_details(input_region, new_input.to_i)

            when "list"
              country_list_by_region(input_region)

            when "exit"
              break
            else
              puts "\nPlease enter a valid input, 1-#{@countries.size}, 'list' or 'exit':"
            end
          end

        when "list"
          Countries::Country.destroy_all
          list_regions

        when "exit"
          status = true

        else
          puts "\nPlease enter a valid input, 1-#{@regions.size}, 'list' or 'exit':".bold.red
        end
    end

  end

  def country_list_by_region(region)
    # select list of countries based on the region
    @countries = Countries::Country.all.select do |country|
      country.region == region
    end
    # print the list of countries as table format
    Table.display_as_table(@countries)
  end

  def country_details(region, input)
    country = @countries[input - 1]
    Table.display_as_summary(country)
    puts "\nWould you like to browse online to see more about #{country.name}? 'yes' or 'no':".bold.cyan
    input = digit_or_word
    if input == "yes"
      link = "https://www.cia.gov/library/publications/the-world-factbook/geos/#{country.alpha2Code.downcase}.html"
      Launchy.open(link)
    end

  end

  def digit_or_word
    input = gets.strip.downcase
    input.match(/\d+/).to_s.to_i == 0 ? input : input.to_i 
  end

  def goodbye
    puts "\nThank you for using countries cli-gem!\n".bold.red
  end

end