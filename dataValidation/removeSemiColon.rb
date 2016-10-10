require 'csv'

csvFile = File.open("foreign_movie_metadata.csv", 'r+')
csvFile.each_line do |line|
#  line.to_s.sub! ';' ''
  line.strip()
  line.chop!
  #if line.end_with?(";")
  
  #end
end
