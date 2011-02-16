require 'rubygems'

use Rack::Static, :urls => ["/css", "/images"], :root => "public"

# the following allows testing of the gem using our stub app
$: << File.expand_path("../lib")
require 'gidget'

gidget = Gidget::Server.new do
  set :title, "My Awesome Blog"
  set :author, "Your Name Goes Here"
  set :summary_size, 100
  set :page_size, 10
end

run gidget