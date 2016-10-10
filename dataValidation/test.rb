file = File.open('test.txt', 'r+')

file.each_line do |line|
  line.gsub(/\s+/, "")
  line.strip
  line.gsub("Budget:", "")
  line.gsub("(estimated)", "")
end
