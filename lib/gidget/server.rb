require 'sinatra/base'
require 'haml'
require 'gidget/file_mapper'


module Gidget
  class Server < Sinatra::Base
    set :haml, :format => :html5


    def initialize(app=nil, &block)
      super(app, &b=nil)
      Server.class_exec(&block) if block_given?
      
      @file_mapper = FileMapper.new
    end


    # route for root
    get '/' do
      haml :index, :locals => { :posts => @file_mapper.posts }
    end


    # route for a specific page
    get %r{^\/[\w,\-,\/]+$} do
      page = @file_mapper.get_page_for_request(request.path)

      if (page != nil)
        haml :page, :locals => { :page => page }
      else
        pass
      end
    end


    # route for a specific post
    get %r{^\/[\w,\-,\/]+$} do
      index = @file_mapper.get_post_index_for_request(request.path)

      if (index != nil)
        haml :post, :locals => { :posts => @file_mapper.posts, :index => index }
      else
        pass
      end
    end
    
    
    # route for a custom view
    get %r{^\/[\w,\-,\/]+$} do
      begin
        haml request.path.to_sym, :locals => { :posts => @file_mapper.posts }
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