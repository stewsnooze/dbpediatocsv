class Dbpedioid
  include Enumerable
  
  W3C = "http://www.w3c.org/2003/01/geo/wgs84_post#"
  DBPEDIA_RESOURCE = "http://dbpedia.org/resource/"
  
  attr_accessor :items, :file, :places, :values
  
  def initialize(file)
    @file = file
    @places = {}
    @items = {}
    @values = []
  end
  
  def process_patterns
    ["<", "/ /", DBPEDIA_RESOURCE].each do |pattern|
      @items[0].gsub!(pattern, "")
    end
  end
  
  def process_characters
    @items[1].gsub!("<", "")
    @items[1].gsub!(/ /, "")
  end
  
  def process_coordinates(place_name, point)
    if @items[1] == "W3C#{point}"
      @items[2].gsub!(/"/, "")
      @places[place_name][point] = @items[2]
    end
  end
  
  def reset_place
    @places = {}
  end
  
  def reset_values
    @values = []
  end
  
  def process
    reset_values
    
    File.open(@file, "r") do |f|
      f.each_line do |line|
        
        line.gsub!("\^", ">")
        
        @items = line.split(/>/)
        
        process_patterns
        
        place_name = @items[0]
      
        unless @places.has_key?(place_name)
          @places[place_name] = {}
          @places[place_name][:name] = place_name
        end
        
        process_characters        
        
        process_coordinates(place_name, :lat)
        
        process_coordinates(place_name, :long)
        
        self << [place_name, @places[place_name][:lat], @places[place_name][:long]].compact.join(",")
        
        reset_place
      end
    end
  end
  
  def each(&block)
    @values.each(&block)
  end
  
  def <<(value)
    @values << value
    self
  end
  
  def size
    @values.size
  end
end