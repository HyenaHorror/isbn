require_relative 'bcrypt.rb'

def read_last_isbn_in_database
  con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])

  rs = con.exec "SELECT * FROM History ORDER BY Id DESC LIMIT 1"
  return rs.to_a
end

def add_isbn_to_history(isbn, status, user)
  con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])

  con.exec "INSERT INTO History VALUES(DEFAULT, '#{isbn}', '#{status}', '#{user}')"
end

def create_new_user(username, password)
  con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])
  passhash = hash_password(password)
  con.exec "INSERT INTO Users VALUES(DEFAULT, '#{username}', '#{passhash}')"
end
def verify_login_information(username, password)
  con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])
  rs = con.exec "SELECT passhash FROM Users WHERE username = #{'username'} LIMIT 1"
  passhash = BCrypt::Password.new rs.to_a[0]["passhash"]
  return passhash == password
end

def is_username_in_use(username)
  con = PG.connect(:dbname => ENV['DBNAME'], :user => ENV['DBUSER'], :password => ENV['DBPASS'])
  rs = con.exec "SELECT username FROM Users WHERE username = '#{username}' LIMIT 1"
  rs.to_a[0] != nil
end
