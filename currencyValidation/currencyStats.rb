require 'csv'
require 'open-uri'

outputList = Array.new
outputFilePath = 'csv/final_result.csv'
inputFilePath = 'csv/result.csv'

#ScrapeResult = Struct.new(:title, :imdb_link, :country, :budget, :gross, :foreign_currency) do
 # def toString
  #  "#{title}, #{imdb_link}, #{country}, #{budget}, #{gross}, #{foreign_currency}"
 # end
#end

#outputList.push ScrapeResult.new('movie_title', 'movie_imdb_link', 'country', 'budget', 'gross', 'foreign_currency')

inputFile = File.open(inputFilePath, 'r+')

inputFile.each_line do |line|
  if line.include? 'true'
    outputList.push line
  end
end


#CSV.foreach(inputFilePath, headers:true) do |row|
#  tempRow = ScrapeResult.new(row['movie_title'], row['movie_imdb_link'], row['country'], row['budget'], row['gross'], row['foreign_currency'])
#  puts tempRow
#  if tempRow[:foreign_currency].eql?('true')
#    puts 'rowData TRUE'
#    outputList.push tempRow.toString
#  end
#end

File.open(outputFilePath, "w+") do |f|
  outputList.each { |element| f.puts(element) }
end
