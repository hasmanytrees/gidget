require 'rubygems'
require 'bundler'

Bundler.require

gidget = Gidget::Server.new do
  set :title, "My Awesome Blog"
  set :author, "Your Name Goes Here"
  set :summary_size, 100
  set :page_size, 10
end

run gidget