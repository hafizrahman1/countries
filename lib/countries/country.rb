class Countries::Country
  attr_accessor :name, :countries

  def self.region
    # I should return a bunch of regions
    # puts <<-DOC.gsub /^\s*/, ''
    #   1.Americas
    #   2.Asia
    # DOC

    region_1 = self.new #Country
    region_1.name = "Americas"
    region_1.countries = [1..10] #list of countries

    region_2 = self.new
    region_2.name = "Africa"
    region_2.countries = [1..10]

    [region_1, region_2]

  end

end