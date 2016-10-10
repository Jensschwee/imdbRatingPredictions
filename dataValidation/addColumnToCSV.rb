require "csv"
require "fileutils"
require "tempfile"

### add column
def addColumn
  temp = Tempfile.new("csv")
  
  CSV.open(temp, "w") do |temp_csv|
    CSV.foreach("foreign_movie_metadata.csv", :row_sep => :auto) do |orig|
      temp_csv << orig + ["gross"] + ["foreign_currency"]
    end
  end
  
  FileUtils.mv(temp, "foreign_movie_metadata.csv", :force => true)
end


addColumn
