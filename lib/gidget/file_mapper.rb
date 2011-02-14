require 'singleton'
require 'gidget/page'
require 'gidget/post'


module Gidget
  class FileMapper
    include Singleton
    
    attr_reader :pages
    attr_reader :posts
    attr_reader :tags
  
  
    def initialize
      @pages = Hash.new
      @posts = Array.new
      @tags = Hash.new
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
  end
end