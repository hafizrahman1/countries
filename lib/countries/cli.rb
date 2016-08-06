# Our CLI Controller
class Countries::CLI

  def call
    puts "List of regions:"
    puts "----------------"
    list_regions
    menu
    goodbye
  end

  def list_regions
    # puts <<-DOC.gsub /^\s*/, ''
    #   1.Americas
    #   2.Asia
    # DOC
    @regions = Countries::Country.region_list
    @regions.each.with_index(1) do |region, i|
      puts "#{i}. #{region}"
    end
  end

  def menu

    input = ""

    while input != "exit"
        puts "Enter the number of the region you'd like more info on or type list again or type exit:"
        input = gets.strip.downcase
        
        if input.to_i > 0 && input.to_i <= 5
          input_region = @regions[input.to_i - 1]
          puts "Region set to: #{input_region}."

        elsif input == "list"
          list_regions
        else
          puts "Not sure you want, type list or exit."
        end
    end

  end

  def goodbye
    puts "Thank you using countries!!!"
  end


end