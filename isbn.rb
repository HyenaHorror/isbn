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
    return true
  else
    return false
  end
end

def remove_extra_characters(params)
  params.delete!("-")
  params.delete!(" ")
  return params
end

def convert_input_to_array(params)
  result = params.split(//).map(&:to_i).map.with_index {|value, index| value = value * (index +1)}
  if params.downcase.include? "x"
    result[-1] = 10
  else
    result[-1] = params[-1].to_i
  end
  return result
end

def convert_input_to_array_isbn13(params)
  result = params.split(//).map(&:to_i).map.with_index {|value, index| if index % 2 != 0 then value *= 3 else value = value end}
  return result
end

def checksum_isbn13(params)
  input = params.clone
  input.pop
  checksum = 10 - (input.sum % 10)
  if checksum == params[-1]
    return true
  else
    return false
  end
end
