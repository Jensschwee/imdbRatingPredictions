require 'csv'

csvFile = File.open("foreign_movie_metadata.csv", 'r+')
csvFile.each_line do |line|
  line.strip()
  if line.end_with?("NOT_DETERMINED")
    line = line + ';'
  end
end

