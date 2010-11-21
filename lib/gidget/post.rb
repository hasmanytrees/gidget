require 'yaml'
require 'gidget/ext'


module Gidget
  class Post < Hash
    def initialize(file_path)  
      file = File.open(file_path, "r")
    
      # read the first paragraph and load it into a Hash with symbols as keys
      self.update(YAML.load(file.gets("")).inject({}) { |h, (k,v)| h.merge(k.to_sym => v) })
    
      file.close()
      
      self[:file_path] = file_path
      
      self[:request_path] = self[:date].strftime("/%Y/%m/%d/") + self[:title].slugize
      
      self[:body] = lambda {
        file = File.open(file_path, "r")
      
        # ignore the first paragraph
        file.gets("")
      
        # capture the rest of the file
        body = file.gets(nil)
      
        file.close()
      
        return body
      }
    end
  end
end