require 'gidget/page'


module Gidget
  class Post < Page
    def request_path
      @meta_data[:permalink] || self.date.strftime("/%Y/%m/") + self.title.slugize
    end
    
    
    def date
      @meta_data[:date]
    end
    
    
    def tags
      @meta_data[:tags] || ""
    end
  end
end