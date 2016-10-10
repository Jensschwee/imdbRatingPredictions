require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

$count
$foreignCount

def get_html
  $count = 0
  $foreignCount = 0

  user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2'

  CSV.foreach('filtered_movie_set.csv', headers: true) do |row|
    url = row['movie_imdb_link']
    doc = Nokogiri::HTML(open(url, 'User-Agent' => user_agent))
    parse_html(doc, row)
    sleep(Random.rand(20)+5)
  end

  puts 'Total movies scraped: ' + $count.to_s
  puts ''
  puts 'Movies with foreign currency found: ' + $foreignCount.to_s
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

  cleanFile('budgetText.txt')
  cleanFile('grossText.txt')
  budgetFile = File.open('budgetText.txt', 'r')
  grossFile = File.open('grossText.txt', 'r')
  budgetFileContent = File.read(budgetFile)
  grossFileContent = File.read(grossFile)

  row['budget'] = budgetFileContent
  row['gross'] = grossFileContent

  if budgetFileContent.include?('$') or grossFileContent.include?('$')
    row['foreign_currency'] = 'false'
  else if budgetFileContent.include?('USD') or grossFileContent.include?('USD')
    row['foreign_currency'] = 'false'
  else if budgetFileContent.include?('dollar') or grossFileContent.include?('dollar')
    row['foreign_currency'] = 'false'
  else if budgetFileContent.include?('dollars') or grossFileContent.include?('dollars')
    row['foreign_currency'] = 'false'
  else
    $foreignCount += 1
    row['foreign_currency'] = 'true'
  end

  $count += 1
  puts $count
end

def cleanFile(file)
  file = File.open(file, 'r')
  oldText = File.read(file)
  newText = oldText.gsub(/\s+/, "").gsub("Budget:", "").gsub("(estimated)", "").gsub("Gross:", "")
  File.open(file, 'w') { |file| file.puts newText }
  puts newText
end

get_html
