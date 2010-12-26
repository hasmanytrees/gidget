require 'rubygems'
require 'bundler'

#Bundler.require

# The following lines are used for debug during gem development
# Comment out previous Bundler.require line to avoid conflicts during development
$: << File.expand_path("../lib")
require 'gidget'

gidget = Gidget::Server.new do
  set :title, "My Awesome Blog"
  set :author, "Your Name Goes Here"
  set :summary_size, 100
  set :page_size, 10
end

run gidget