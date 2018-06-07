require_relative 'bcrypt.rb'
require 'uri'

load './local_env.rb' if File.exist?('./local_env.rb')
def read_last_isbn_in_database
  # con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])
  uri = URI.parse(ENV['DATABASE_URL'])
  con = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)

  rs = con.exec "SELECT * FROM History ORDER BY Id DESC LIMIT 1"
  return rs.to_a
end

def add_isbn_to_history(isbn, status, user)
  # con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])
  uri = URI.parse(ENV['DATABASE_URL'])
  con = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)

  con.exec "INSERT INTO History VALUES(DEFAULT, '#{isbn}', '#{status}', '#{user}')"
end

def create_new_user(username, password)
  # con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])
  uri = URI.parse(ENV['DATABASE_URL'])
  con = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  passhash = hash_password(password)
  puts "New user: #{username}"
  con.exec "INSERT INTO Users VALUES(DEFAULT, '#{username}', '#{passhash}')"
end
def verify_login_information(username, password)
  # con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])
  uri = URI.parse(ENV['DATABASE_URL'])
  con = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  rs = con.exec "SELECT passhash FROM Users WHERE username = #{'username'} LIMIT 1"
  db_hash = rs.to_a[0]["passhash"]
  passhash = BCrypt::Password.new db_hash
  # rescue BCrypt::Errors::InvalidHash
    return db_hash == passhash
end

def is_username_in_use(username)
  # con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])
  uri = URI.parse(ENV['DATABASE_URL'])
  con = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  rs = con.exec "SELECT username FROM Users WHERE username = '#{username}' LIMIT 1"
  rs.to_a[0] != nil
end

def get_full_history
  uri = URI.parse(ENV['DATABASE_URL'])
  con = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)

  rs = con.exec "SELECT * FROM History"
  return rs.to_a
end
