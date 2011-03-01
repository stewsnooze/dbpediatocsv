file = File.new("ARGV[0]", "r")
@places = {}

while (line = file.gets)

  # Item name
  items = line.gsub!("\^",">").split(/>/)

  ["<",  "/ /",  "http://dbpedia.org/resource"].each do |pattern|
    items[0].gsub!(pattern, "")
  end
  
  place_name = items[0]

  if !@places.has_key?(place_name)
    #warn place_name
    @places[place_name] = {}
    @places[place_name][:name] = place_name
  end

  items[1].gsub!("<","")
  items[1].gsub!(/ /,"")
  
  %w(lat long).each do |coord|
    if items[1] == "http://www.w3.org/2003/01/geo/wgs84_pos##{coord}"
      items[2].gsub!(/"/,"")
      @places[place_name][coord.to_sym] = items[2]
      puts place_name + "," + @places[place_name][:lat] + "," + @places[place_name][:long] if coord == 'long'
    end
  end
end
file.close