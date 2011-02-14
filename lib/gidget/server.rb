require 'sinatra/base'
require 'benchmark'
require 'haml'
require 'gidget/file_mapper'


module Gidget
  class Server < Sinatra::Base
    set :haml, :format => :html5


    def initialize(app=nil, &block)
      super(app, &b=nil)
      Server.class_exec(&block) if block_given?
      
      # load the file mapper
      puts Benchmark.measure { FileMapper.instance.load }
    end


    # route for root
    get '/' do
      haml :index, :locals => { :posts => FileMapper.instance.posts }
    end


    # route for a specific page
    get %r{^\/[\w,\-,\/]+$} do
      page = FileMapper.instance.pages[request.path]

      if (page != nil)
        haml :page, :locals => { :page => page }
      else
        pass
      end
    end


    # route for a specific post
    get %r{^\/[\w,\-,\/]+$} do
      index = nil

      FileMapper.instance.posts.each_with_index { |p, i|
        if (p.request_path == request.path)
          index = i
          break
        end
      }

      if (index != nil)
        haml :post, :locals => { :posts => FileMapper.instance.posts, :index => index }
      else
        pass
      end
    end
    
    
    # route for a custom view
    get %r{^\/[\w,\-,\/]+$} do
      begin
        haml request.path.to_sym, :locals => { :posts => FileMapper.instance.posts }
      rescue
        pass
      end
    end
    
    
    # make all requests cached for a day
    after do
      expires(86400, :public)
    end
  end
end