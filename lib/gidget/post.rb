require 'yaml'
require 'rdiscount'
require 'gidget/ext'


module Gidget
  class Post
    attr_reader :file_path
    attr_reader :request_path
    attr_reader :meta_data
    
    
    def initialize(file_path)
      @file_path = file_path
      
      begin 
        file = File.open(@file_path, "r")
    
        # read the first paragraph and load it into a Hash with symbols as keys
        @meta_data = YAML.load(file.gets("")).inject({}) { |h, (k,v)| h.merge(k.to_sym => v) }
      ensure
        file.close()
      end
      
      @request_path = @meta_data[:date].strftime("/%Y/%m/%d/") + @meta_data[:title].slugize
    end
    
    
    def body
      begin
        file = File.open(@file_path, "r")
    
        # ignore the first paragraph
        file.gets("")
    
        # read the rest of the file and process it's markdown
        RDiscount.new(file.gets(nil)).to_html
      ensure
        file.close()
      end
    end
    
    
    def method_missing(m, *args, &block)  
      if (@meta_data.has_key?(m))
        return @meta_data[m]
      else
        super
      end
    end
  end
end