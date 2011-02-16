require 'gidget/page'


module Gidget
  class Post < Page
    def request_path
      @meta_data[:permalink] || self.date.strftime("/%Y/%m/%d/") + self.title.slugize
    end
    
    
    def date
      @meta_data[:date]
    end
    
    
    def summary
      begin
        file = File.open(@file_path, "r")

        # ignore the first paragraph
        file.gets("")

        # read the next paragraph of the file and process markdown
        RDiscount.new(file.gets("")).to_html
      ensure
        file.close()
      end
    end
  end
end