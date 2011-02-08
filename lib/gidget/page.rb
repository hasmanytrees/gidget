require 'rdiscount'
require 'yaml'
require 'gidget/ext'


module Gidget
  class Page
    attr_reader :file_path
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
    end


    def request_path
      @meta_data[:permalink] || "/" + self.title.slugize
    end


    def title
      @meta_data[:title]
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
      @meta_data[m] || super
    end
  end
end