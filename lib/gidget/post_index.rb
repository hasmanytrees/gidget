require 'singleton'
require 'gidget/post'


module Gidget
  class PostIndex < Array
    include Singleton


    def initialize
      paths = Dir.glob("posts/**/*.txt")

      paths.each { |file_path|
        self << Post.new(file_path)
      }
    
      self.replace self.sort_by { |p| p[:request_path] }.reverse!

      puts "Post Index created, size = " + self.size.to_s
    end
  end
  
  
  PostIndex.instance
end