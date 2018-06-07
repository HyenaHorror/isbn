require 'sinatra'
require 'erb'
require 'csv'
require 'pg'
require 'bcrypt'
require_relative 'isbn.rb'
# require_relative 'aws.rb'
require_relative 'psql.rb'
enable :sessions

# Ensures current file is up-to-date.
# checked = "checked_numbers.csv"
# pull_csv_from_s3_into_local(checked, checked)

get '/' do
  session[:error] = ""
  erb :index
end

post '/guest' do
  session[:name] = "Guest"
  redirect '/check_if_valid'
end

get '/login' do
  erb :login, locals:{message:session[:error]}
end

post '/gotologin' do
  redirect '/login'
end

post '/login_submit' do
  if verify_login_information(params[:username].downcase, params[:password]) == true
    session[:name] = get_login_users_name(params[:username].downcase)
    session[:error] = ""
    redirect '/check_if_valid'
  else
    session[:error] = "Invalid username/password!"
    redirect '/login'
  end
end

get '/guest' do
  session[:name] = 'Guest'
  redirect '/check_if_valid'
end

get '/signup' do
  erb :signup
end

post '/signup_submit' do
  session[:error] = ""
  if is_username_in_use(params[:username].downcase) == true
    session[:error] = 'Username is already in use!'
    redirect '/signup'
  else
    create_new_user(params[:username].downcase, params[:password])
    session[:name] = params[:username].downcase
    redirect '/check_if_valid'
  end
end

get '/check_if_valid' do
  erb :check_if_valid
end

post '/check_input' do
  session[:value] = params[:isbn_value]
  session[:type] = params[:isbn_value].length == 10 ||  params[:isbn_value].length == 13 ? "isbn#{params[:isbn_value].length}" : "invalid"
  session[:status] = process_isbn(params[:isbn_value])
  # checked = "checked_numbers.csv"
  puts "session[:value] is #{session[:value]}"
  puts "session[:name]: #{session[:name]}"
  # csv_add_isbn(checked, session[:value], session[:status], session[:name])
  # upload_new_file_to_bucket(checked)
  add_isbn_to_history(session[:value].to_s, session[:status], session[:name])
  redirect '/validation' #?type=' + type + '&value=' + value + '&status=' + isbn_status.to_s
end

get '/validation' do
  erb :validation, locals:{type:session[:type],value:session[:value],status:session[:status]}
end

get '/history' do
  # checked_numbers = csv_read_file("checked_numbers.csv")
  checked_numbers = get_full_history
  erb :history, locals:{checked_numbers:checked_numbers}
end

get '/contact' do
  erb :contact
end

get '/about' do
  erb :about
end

get '/privacy' do
  erb :privacy
end
