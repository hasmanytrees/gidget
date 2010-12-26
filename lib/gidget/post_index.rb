require 'singleton'
require 'gidget/post'


module Gidget
  class PostIndex < Array
    include Singleton


    def initialize
      paths = Dir.glob("posts/**/*.txt")

      # add all the posts to the array
      paths.each { |file_path|
        self << Post.new(file_path)
      }
    
      # sort the array by the request path, descending (newest by date will be first)
      self.replace self.sort_by { |p| p.request_path }.reverse!

      puts "Post Index created, size = " + self.size.to_s
    end
  end
end