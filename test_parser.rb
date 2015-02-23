require 'open-uri'
require 'hpricot'

url = "https://github.com/tblobaum/redis-stream"

doc = Hpricot( open(url).read() )
(doc/:a).each do |link|
  href = link[:href]
  if href != nil then
    puts "href: #{href}\n"
  end
end
