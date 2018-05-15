require 'sinatra'
require 'erb'
require 'csv'
require_relative 'isbn.rb'
require_relative 'aws.rb'
enable :sessions

# Ensures current file is up-to-date.
checked = "checked_numbers.csv"
pull_csv_from_s3_into_local(checked, checked)

get '/' do
  erb :check_if_valid
end
=begin Login/Signup
post '/login_submit' do
  if temp_userpass(params[:username], params[:password]) == true
    redirect '/check_if_valid'
  else
    redirect '/'
  end
end

get '/signup' do
  erb :signup
end

post '/signup_submit' do
  new_user = {
    "name" => params[:name],
    "email" => params[:l_name],
    "password" => params[:l_name],
    # "gender" => params[:gender],
    # "b_day" => [params[:month], params[:day], params[:year]],
  }

  function_for_adding_new_user(new_user)
  session[:current_user]
  redirect '/check_if_valid'
end
=end
get '/check_if_valid' do
  erb :check_if_valid
end

post '/check_input' do
  value = params[:isbn_value]
  type = "isbn#{params[:isbn_value].length}"
  isbn_status = process_isbn(params[:isbn_value])
  checked = "checked_numbers.csv"

  csv_add_isbn(checked, value, isbn_status, "Admin")
  upload_new_file_to_bucket(checked)
  redirect '/validation?type=' + type + '&value=' + value + '&status=' + isbn_status.to_s
end

get '/validation' do
  erb :validation, locals:{type:params[:type],value:params[:value],status:params[:status]}
end
