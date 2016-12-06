require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

$count
$foreignCount
$resultList

#ONE
#$inputFilePath = 'csv/foreign_movie_metadata_one.csv'
#$outputFilePath = 'csv/result_one.csv'

#TWO
#$inputFilePath = 'csv/foreign_movie_metadata_two.csv'
#$outputFilePath = 'csv/result_two.csv'

#THREE
#$inputFilePath = 'csv/foreign_movie_metadata_three.csv'
#$outputFilePath = 'csv/result_three.csv'

#FOUR
#$inputFilePath = 'csv/foreign_movie_metadata_four.csv'
#$outputFilePath = 'csv/result_four.csv'

#FIVE
$inputFilePath = 'csv/foreign_movie_metadata_five.csv'
$outputFilePath = 'csv/result_five.csv'

$budgetFilePath = 'txt/budgetText.txt'
$grossFilePath = 'txt/grossText.txt'

ScrapeResult = Struct.new(:title, :imdb_link, :country, :budget, :gross, :foreign_currency) do
  def toString
    "#{title}, #{imdb_link}, #{country}, #{budget}, #{gross}, #{foreign_currency}"
  end
end

def get_html
  $count = 0
  $foreignCount = 0
  $resultList = Array.new
  # only include the line below if you're scraping file ONE
  # $resultList.push ScrapeResult.new('movie_title', 'movie_imdb_link', 'country', 'budget', 'gross', 'foreign_currency')
  
  user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2'
  begin
    CSV.foreach($inputFilePath, headers: true) do |row|
      url = row['movie_imdb_link']
      doc = Nokogiri::HTML(open(url, 'User-Agent' => user_agent))
      parse_html(doc, row)
      sleep(Random.rand(10)+10)
    end
  ensure
    puts 'Total movies scraped: ' + $count.to_s
    puts ''
    puts 'Movies with foreign currency found: ' + $foreignCount.to_s
    puts ''
    puts 'Writing result of scrape to file'
    puts ''
    
    File.open($outputFilePath, "w+") do |f|
      $resultList.each { |element| f.puts(element.toString) }
    end
  end
  
end

def parse_html(doc, row)
  doc.xpath('//div').each do |node|
    if node.text.include?("Budget:")
      File.open($budgetFilePath, 'w') {|f| f.write(node.text) }
    end
    if node.text.include?("Gross:")
      File.open($grossFilePath, 'w') {|f| f.write(node.text) }
    end
  end

  cleanFile($budgetFilePath)
  cleanFile($grossFilePath)
  budgetFile = File.open($budgetFilePath, 'r')
  grossFile = File.open($grossFilePath, 'r')
  budgetFileContent = File.read(budgetFile)
  grossFileContent = File.read(grossFile)

  puts ''
  puts 'File Content after budget and gross cleaning'
  puts budgetFileContent
  puts grossFileContent
  puts ''
  
  currency = nil

  if budgetFileContent.include?('$') && grossFileContent.include?('$')
    currency = 'false'
  elsif budgetFileContent.include?('USD') && grossFileContent.include?('USD')
    currency = 'false'
  elsif budgetFileContent.include?('dollar') && grossFileContent.include?('dollar')
    currency = 'false'
  elsif budgetFileContent.include?('dollars') && grossFileContent.include?('dollars')
    currency = 'false'
  else
    $foreignCount += 1
    currency = 'true'
  end

  $count += 1
  puts $count
  puts 'Adding to list'
  $resultList.push ScrapeResult.new(row['movie_title'], row['movie_imdb_link'], row['country'], budgetFileContent.strip, grossFileContent.strip, currency)
end

def cleanFile(file)
  file = File.open(file, 'r')
  oldText = File.read(file)
  newText = oldText.gsub(/\s+/, "").gsub("Budget:", "").gsub("(estimated)", "").gsub("Gross:", "").gsub("\n", "").gsub(",", "")
  File.open(file, 'w') { |file| file.puts newText }
  puts newText
end

get_html()
