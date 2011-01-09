require 'singleton'
require 'gidget/post'
require 'gidget/tag_index'


module Gidget
  class PostIndex < Array
    include Singleton


    def load
      paths = Dir.glob("posts/**/*.txt")

      # add all the posts to the array
      paths.each { |file_path|
        self << Post.new(file_path)
      }
    
      # sort the array by the request path, descending (newest by date will be first)
      self.replace self.sort_by { |p| p.request_path }.reverse!

      puts "Post Index created, size = " + self.size.to_s
      
      # load the tag index
      TagIndex.instance.load self
    end
  end
end