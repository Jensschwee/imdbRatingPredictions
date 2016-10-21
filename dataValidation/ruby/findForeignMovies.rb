require "csv"

newFile = File.open("csv/foreign_movie_metadata.csv", 'w')
foreignCount = 0
hollywoodCount = 0

CSV.foreach("csv/filtered_movie_set.csv", headers: true) do |orig|
  temp = orig['country'].to_s
  if !temp.include?("US") 
    newFile << orig
    foreignCount = foreignCount + 1
  else
    hollywoodCount = hollywoodCount + 1
  end
end

puts "Foreign Movies: "
puts foreignCount
puts "US Movies: "
puts hollywoodCount
