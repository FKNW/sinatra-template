require 'rubygems'
Bundler.setup
Bundler.require
require 'yaml'
$stdout.sync = true if development?
require 'sinatra/reloader' if development?

require File.dirname(__FILE__)+'/bootstrap'
Bootstrap.init :models, :helpers, :controllers

set :haml, :escape_html => true


map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'
  environment.append_path 'assets/images'
  run environment
end

map '/' do
  run App
end
