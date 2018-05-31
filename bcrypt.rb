require 'bcrypt'

def hash_password(password)
  result = BCrypt::Password.create(password, cost: 4)
  return result
end
