require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

$count

def get_html
  $count = 0
  CSV.foreach('filtered_movie_set.csv', headers: true) do |row|
    url = row['movie_imdb_link']
    doc = Nokogiri::HTML(open(url))
    parse_html(doc, row)
  end
end

def parse_html(doc, row)
  doc.xpath('//div').each do |node|
    if node.text.include?("Budget:")
      File.open("budgetText.txt", 'w') {|f| f.write(node.text) }
    end
    if node.text.include?("Gross:")
      File.open("grossText.txt", 'w') {|f| f.write(node.text) }
    end
  end
  File.open('budgetText.txt').each_line.any?{|line|
    line.gsub(/\s+/, "")
    line.strip
    line.gsub("Budget:", "")
    line.gsub("(estimated)", "")
    if line.include?('$')
      row['budget'] = line
    end
  }
  File.open('grossText.txt').each_line.any?{|line|
    if line.include?('$')
      row['gross'] = line
    end
  }
  row['foreign_currency'] = 'false'
  


  $count += 1    
  puts $count
end

get_html
