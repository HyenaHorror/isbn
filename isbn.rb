def isbn10 (params)
  if params.length == 10
    params = params.split(//).map(&:to_i)
    if params[9] == 0
      params[9] = 10
    end
    if isbn_multiply_digits(params).sum % 11 == 0
      return true
    else
      return false
    end
  else
    return false
  end
end

def isbn_multiply_digits(params)
  result = Array.new
  params.each_with_index do |digit, index|
    result.push digit * (index + 1)
  end
  return result
end

def remove_extra_characters(params)
  params.delete!("-")
  params.delete!(" ")
  return params
end
