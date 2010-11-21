require 'sinatra/base'
require 'gidget/post_index'


module Gidget
  class Server < Sinatra::Base
    set :haml, :format => :html5


    get '/' do   
      expires(86400, :public)

      haml :index, :locals => { :posts => PostIndex.instance }
    end


    get %r{^\/\d{4}\/\d{2}\/\d{2}\/\w+} do
      post = nil
  
      PostIndex.instance.each { |p|
        if (p[:request_path] == request.path)
          post = p
          break
        end
      }
  
      if (post != nil)
        expires(86400, :public)

        haml :post, :locals => { :post => post }
      end
    end


    get %r{^\/\d{4}(\/\d{2}(\/\d{2})?)?$} do
      posts = PostIndex.instance.select { |p|
        p[:request_path] =~ %r{^#{request.path}}
      }
      
      expires(86400, :public)
  
      haml :archive, :locals => { :posts => posts }
    end
    
    
    get %r{^\/\w+} do
      begin
        expires(86400, :public)
        
        haml request.path.to_sym, :locals => { :posts => posts }
      rescue 
        pass
      end
    end
  end
end