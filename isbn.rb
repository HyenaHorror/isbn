def process_isbn(type, value)
  if type == "isbn10"
    isbn10(value)
  elsif type == "isbn13"
    isbn13(value)
  else
    return false
  end
end

def isbn10 (params)
  isbn_array = convert_input_to_array(remove_extra_characters(params))
  if isbn_array.length == 10
    check_sum = isbn_array.delete_at(9)
    if isbn_array.sum % 11 == check_sum
      return true
    else
      return false
    end
  else
    return false
  end
end

def isbn13(params)
  isbn13 = remove_extra_characters(params)
  if isbn13.length == 13
    checksum_isbn13(convert_input_to_array_isbn13(isbn13))
  else
    return false
  end
end

def remove_extra_characters(params)
  params.gsub(/\W/, '') #Removes all non-alphanumeric values (\W)
end

def convert_input_to_array(params)
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
  return result
end

def checksum_isbn13(params)
  input = params.slice(0..-2) #Duplicates params without last element.
  checksum = 10 - (input.sum % 10)
  if checksum == params[-1]
    return true
  else
    return false
  end
end

def csv_read_file(file)
  data = CSV.read(file, {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})

  hashed_data = data.map { |d| d.to_hash }

  # puts "hashed_data.class #{hashed_data.class}"
  # puts hashed_data
  return hashed_data
end

def csv_add_isbn(file, isbn, status, user)
  CSV.open(file, "a") do |csv|
    csv << [isbn, status, user]
  end
end
