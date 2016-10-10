file = File.open('test.txt', 'r')

oldText = File.read(file)
newText = oldText.gsub(/\s+/, "").gsub("Budget:", "").gsub("(estimated)", "")

File.open('test.txt', 'w') { |file| file.puts newText }

puts newText
