file = File.new("ARGV[0]", "r")

@places = {}
while (line = file.gets)

  # Item name
  line = line.gsub("\^",">")
  items = line.split(/>/)
  items[0].gsub!("<","")
  items[0].gsub!(/ /,"")
  items[0].gsub!("http://dbpedia.org/resource/","")
  place_name = items[0]

  if !@places.has_key?(place_name)
    #warn place_name
    @places[place_name] = {}
    @places[place_name][:name] = place_name
  end

  items[1].gsub!("<","")
  items[1].gsub!(/ /,"")

  if items[1] == "http://www.w3.org/2003/01/geo/wgs84_pos#lat"
    items[2].gsub!(/"/,"")
    @places[place_name][:lat] = items[2]
  end

  if items[1] == "http://www.w3.org/2003/01/geo/wgs84_pos#long"
    items[2].gsub!(/"/,"")
    @places[place_name][:long] = items[2]
    
    # This next code line is a savage hack because I have to go out!
    puts "#{place_name}, #@places[place_name][:lat], #@places[place_name][:long]"
  end

end
file.close