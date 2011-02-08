require 'gidget/page'
require 'gidget/ext'


module Gidget
  class Post < Page
    def date
      @meta_data[:date]
    end
    
    
    def request_path
      @meta_data[:permalink] || self.date.strftime("/%Y/%m/") + self.title.slugize
    end
    
    
    def tags
      @meta_data[:tags] || ""
    end
  end
end