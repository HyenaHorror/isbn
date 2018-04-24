require 'sinatra'
require 'erb'
require_relative 'isbn.rb'

get '/' do
  erb :check_if_valid
end

post '/check_input' do
  isbn_status = process_isbn(params[:isbn_type], params[:isbn_value])
  redirect '/validation?type=' + params[:isbn_type] + '&value=' + params[:isbn_value] + '&status=' + isbn_status.to_s
end

get '/validation' do
  value = params[:value]
  status = params[:status]
  type = params[:type]
  erb :validation, locals:{type:type,value:value,status:status}
end
