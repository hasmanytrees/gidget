require 'rubygems'
require 'bundler'

Bundler.require

gidget =  Gidget::Server.new do
  set :title, "hasmanytrees"
  set :author, "Forrest Robertson"
  set :summary_size, 100
  set :page_size, 10
end

run gidget