require 'benchmark'
require 'gidget/page'
require 'gidget/post'


module Gidget
  class FileMapper
    
    attr_reader :pages
    attr_reader :posts
  
  
    def initialize
      @pages = Hash.new
      @posts = Array.new
      
      puts Benchmark.measure { self.load }
    end

    
    def load
      page_paths = Dir.glob("pages/**/*.txt")

      # load the page index
      page_paths.each { |file_path|
        page = Page.new(file_path)
        @pages[page.request_path] = page
      }
      
      puts "Page Index created, size = " + @pages.keys.size.to_s
      
      
      post_paths = Dir.glob("posts/**/*.txt")

      # load the post index
      post_paths.each { |file_path|
        post = Post.new(file_path)
        @posts << post
      }
      
      # sort the post index by date descending (newest will be first)
      @posts.replace @posts.sort_by { |p| Time.parse(p.date.to_s).to_i }.reverse!
      
      puts "Post Index created, size = " + @posts.size.to_s
    end
    
    
    def get_page_for_request(request_path)
      self.pages[request_path]
    end
    
    
    def get_post_index_for_request(request_path)
      index = nil

      self.posts.each_with_index { |p, i|
        if (p.request_path == request_path)
          index = i
          break
        end
      }
      
      index
    end
  end
end