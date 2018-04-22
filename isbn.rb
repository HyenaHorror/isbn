def isbn10 (params)
  if params.length == 10
    return true
  else
    return false
  end
end

def isbn_multiply_digits(params)
  params = params.split(//).map(&:to_i)
  result = Array.new
  params.each_with_index do |digit, index|
    result.push digit * (index + 1)
  end
  return result
end
