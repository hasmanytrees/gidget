require 'sinatra/base'
require 'haml'
require 'rdiscount'
require 'gidget/post_index'


module Gidget
  class Server < Sinatra::Base
    set :haml, :format => :html5

    set :page_size, 5

    def initialize(app=nil, &block)
      super(app, &b=nil)
      self.class.instance_eval(&block) if block_given?
    end


    get '/' do
      render_view(:index, { :posts => PostIndex.instance })
    end


    get %r{^\/\d{4}\/\d{2}\/\d{2}\/\w+} do
      index = nil
  
      PostIndex.instance.each_with_index { |p, i|
        if (p[:request_path] == request.path)
          index = i
          break
        end
      }
  
      if (index != nil)
        render_view(:post, { :posts => PostIndex.instance, :index => index })
      end
    end


    get %r{^\/\d{4}(\/\d{2}(\/\d{2})?)?$} do
      posts = PostIndex.instance.select { |p|
        p[:request_path] =~ %r{^#{request.path}}
      }
  
      render_view(:archive, { :posts => posts })
    end
    
    
    get %r{^\/\w+} do
      begin
        render_view(request.path.to_sym, { :posts => PostIndex.instance })
      rescue 
        pass
      end
    end
    
    
    def render_view(view, locals)
      expires(86400, :public)
      
      haml view, :locals => locals
    end
  end
end