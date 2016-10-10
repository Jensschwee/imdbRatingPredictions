require "csv"

puts "Counting semicolons..."
csvFile = File.open("foreign_movie_metadata.csv", 'r+')
semiColonCount = 0
csvFile.each_char do |char|
  if char == ';'
    semiColonCount += 1
  end
end
puts semiColonCount

