def temp_userpass(username, password)
  #This function is a placeholder. Will be replaced later with account creation.
  if username.downcase == "admin" && password == "admin"
    true
  elsif username.downcase == "nsf" && password == "smashthestate"
    true
  else
    false
  end
end

def process_isbn(value)
  isbn = remove_extra_characters(value)
  if isbn.length == 10
    isbn10(isbn)
  elsif isbn.length == 13
    isbn13(isbn)
  else
    return false
  end
end

def isbn10 (params)
  isbn_array = convert_input_to_array(params)
  check_sum = isbn_array.delete_at(9)
  isbn_array.sum % 11 == check_sum
end

def isbn13(params)
  checksum_isbn13(convert_input_to_array_isbn13(params))
end

def remove_extra_characters(params)
  params.gsub(/\W/, '') #Removes all non-alphanumeric values (\W)
end

def convert_input_to_array(params) #for isbn10
  #Splits each string character into separate array elements, turning into integers. Then iterates over each by multiplying it by its position in the string (index plus one, i.e. third position is (2+1)).
  result = params.split(//).map(&:to_i).map.with_index {|value, index| value = value * (index +1)}
  #Determines check digit by checking original parameters for X.
  if params.downcase.include? "x"
    result[-1] = 10
  else
    result[-1] = params[-1].to_i
  end
  return result
end

def convert_input_to_array_isbn13(params)
  #Splits each string character into separate array elements, turning into ints. Then iterate over each element with the index value to multiply by 3 (if index is not even, i.e. 'every other one')
  result = params.split(//).map(&:to_i).map.with_index {|value, index| if index % 2 != 0 then value *= 3 else value = value end}
end

def checksum_isbn13(params)
  10 - (params.slice(0..-2).sum % 10) == params[-1]
end

def csv_read_file(file)
  data = CSV.read(file, {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
  hashed_data = data.map { |d| d.to_hash }
end

def csv_add_isbn(file, isbn, status, user)
  #a, write mode at end of file
  #b, binary mode to prevent Windows malforming files
  CSV.open(file, "ab") do |csv|
    csv << [isbn, status, user]
  end
end

def csv_create_new(filename, columns)
  CSV.open(filename, "wb") do |csv|
    csv << columns.split(",")
  end
end
