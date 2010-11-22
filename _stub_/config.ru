require 'rubygems'
require 'bundler'

Bundler.require


use Rack::Static, :urls => ["/css"]


run Gidget::Server