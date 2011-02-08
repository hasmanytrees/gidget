require 'sinatra/base'
require 'benchmark'
require 'haml'
require 'gidget/file_mapper'


module Gidget
  class Server < Sinatra::Base
    set :haml, :format => :html5

    set :page_size, 5


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
    
    
    # route for an archive listing in the format /archive/yyyy/mm (year and month are optional)
    get %r{^\/archive(\/(\d{4})(\/(\d{2}))?)?$} do
      if (params[:captures] == nil)
        posts = FileMapper.instance.posts
      else
        year = params[:captures][1]
        month = params[:captures][3]
        
        prefix = "#{year}#{month}"
        
        posts = FileMapper.instance.posts.select { |p|
          p.date.strftime("%Y%m").starts_with? prefix
        }
      end
  
      haml :archive, :locals => { :posts => posts, :year => year, :month => month }
    end


    # route for post paging
    get %r{^\/page\/(\d+)$} do
      current_page = params[:captures][0].to_i
      total_pages = (FileMapper.instance.posts.size + settings.page_size - 1) / settings.page_size

      if (current_page <= total_pages)
        posts = FileMapper.instance.posts[(current_page - 1) * settings.page_size, settings.page_size]

        haml :post_paging, :locals => { :posts => posts, :current_page => current_page, :total_pages => total_pages }
      else
        pass
      end
    end


    # route for list of posts tagged with a particular tag
    get %r{^\/tag\/([\w,\-]+)$} do
      posts = FileMapper.instance.tags[params[:captures][0]]

      if (posts != nil)
        haml :tag, :locals => { :posts => posts }
      else
        pass
      end
    end
    
    
    # make all requests cached for a day
    after do
      expires(86400, :public)
    end
  end
end