def isbn10 (params)
  isbn_array = convert_input_to_array(params)
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
