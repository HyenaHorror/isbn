require_relative 'bcrypt.rb'
require 'uri'

load './local_env.rb' if File.exist?('./local_env.rb')
uri = URI.parse(ENV['DATABASE_URL'])
$con = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)

def read_last_isbn_in_database
  rs = $con.exec "SELECT * FROM History ORDER BY Id DESC LIMIT 1"
  return rs.to_a
end

def add_isbn_to_history(isbn, status, user)
  $con.exec "INSERT INTO History VALUES(DEFAULT, '#{isbn}', '#{status}', '#{user.gsub("'", "''")}')"
end

def create_new_user(username, name, password)
passhash = hash_password(password)
  $con.exec "INSERT INTO Users VALUES(DEFAULT, '#{username}', '#{name.gsub("'", "''")}', '#{passhash.to_s}')"
end
def verify_login_information(username, password)
rs = $con.exec "SELECT passhash FROM Users WHERE username = '#{username}' LIMIT 1"
  db_hash = rs.to_a[0]["passhash"]
  passhash = BCrypt::Password.new(db_hash)
  puts "rs: #{rs.to_a[0]}"

  return passhash == password
# rescue BCrypt::Errors::InvalidHash
rescue NoMethodError # in case user is not valid
  return false
end

def is_username_in_use(username)
  rs = $con.exec "SELECT username FROM Users WHERE username = '#{username}' LIMIT 1"
  rs.to_a[0] != nil
end

def get_full_history
  rs = $con.exec "SELECT * FROM History"
  return rs.to_a
end

def get_login_users_name(username)
  rs = $con.exec "SELECT Name FROM Users WHERE Username = '#{username}' LIMIT 1"
  return rs.to_a[0]["name"].gsub("''", "'")
end
