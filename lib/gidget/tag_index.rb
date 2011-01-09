require 'singleton'
require 'gidget/post'


module Gidget
  class TagIndex < Hash
    include Singleton

    
    def load posts
      posts.each { |post|
        tags = nil
        
        if (post.meta_data.has_key? :tags)
          tags = post.meta_data[:tags].split(',')
          
          tags.each { |tag|
            tag.strip!
            
            if (!self.has_key? tag)
              self[tag] = []
            end
            
            self[tag] << post
          }
        end
      }
    end
  end
end