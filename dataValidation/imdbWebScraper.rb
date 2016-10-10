require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

$count

def get_html
  $count = 0
  CSV.foreach('movie_metadata.csv', headers: true) do |row|
    url = row['movie_imdb_link']
    doc = Nokogiri::HTML(open(url))
    parse_html(doc)
  end
end
#File.open("test.html", 'w') {|f| f.write(doc.to_s) }

def parse_html(doc)
  doc.xpath('//div').each do |node|
    if node.text.include?("Budget:")
      File.open("nodeText.txt", 'w') {|f| f.write(node.text) }
    end
  end
  if File.open('nodeText.txt').each_line.any?{|line| line.include?('$')}
    
  else
    $count = $count + 1
  end
  puts $count
end

get_html

puts "FINAL COUNT OF FILMS WITH BUDGET IN DOLLARS"
puts $count
