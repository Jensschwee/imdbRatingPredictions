require 'open-uri'
require 'csv'

#input files
$scrapeOnePath = 'csv/result_one.csv'
$scrapeTwoPath = 'csv/result_two.csv'
$scrapeThreePath = 'csv/result_three.csv'
$scrapeFourPath = 'csv/result_four.csv'

#output file
$outputPath = 'csv/result.csv'

scrapeOne = File.read($scrapeOnePath)
scrapeTwo = File.read($scrapeTwoPath)
scrapeThree = File.read($scrapeThreePath)
scrapeFour = File.read($scrapeFourPath)

File.open($outputPath, 'w') do |file|
  file.puts scrapeOne
  file.puts scrapeTwo
  file.puts scrapeThree
  file.puts scrapeFour
end
