require 'sinatra'
require 'erb'
require_relative 'isbn.rb'

get '/' do
  erb :check_if_valid
end
