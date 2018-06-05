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
  rs = con.exec "SELECT * FROM History ORDER BY Id DESC LIMIT 1"


  passhash = hash_password(password)
end
