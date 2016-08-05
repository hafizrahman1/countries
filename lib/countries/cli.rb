# Our CLI Controller
class Countries::CLI

  def call
    puts "List of regions:"
    list_regions
    menu
    goodbye
  end

  def list_regions
    # puts <<-DOC.gsub /^\s*/, ''
    #   1.Americas
    #   2.Asia
    # DOC
    @regions = Countries::Country.region
  end

  def menu

    input = ""

    while input != "exit"
        puts "Enter the number of the region you'd like more info on or type list again or type exit:"
        input = gets.strip.downcase
        case input
          when "1"
            puts "More info on region 1...."
          when "2"
            puts "Mpre info on region 2...."
          when "list"
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