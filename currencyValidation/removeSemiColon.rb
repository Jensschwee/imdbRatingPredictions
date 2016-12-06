require 'csv'

csvFile = File.open("foreign_movie_metadata.csv", 'r+')
csvFile.each_line do |line|
  line.gsub(";", "")
end
