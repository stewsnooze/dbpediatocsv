Parses the Wikipedia dbpedia xmlish files into CSV

For instance it can parse the geo_coordinates_en.nq file from http://downloads.dbpedia.org/3.5.1/en/ 

Now with brand brain-spanking OOP goodness:

```ruby 

d = Dbpedioid.new('pnd_en.nq')

d.process

puts d.size

d.each(&:inspect)
```
