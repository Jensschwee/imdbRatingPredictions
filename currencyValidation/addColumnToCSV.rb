require "csv"
require "fileutils"
require "tempfile"

### add column
def addColumn
  temp = Tempfile.new("csv")
  
  CSV.open(temp, "w") do |temp_csv|
    CSV.foreach("csv/foreign_movie_metadata.csv", :row_sep => :auto) do |orig|
      temp_csv << orig + ["budget"] + ["gross"] + ["foreign_currency"]
    end
  end
  
  FileUtils.mv(temp, "csv/foreign_movie_metadata.csv", :force => true)
end


addColumn
