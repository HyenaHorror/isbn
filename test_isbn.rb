require "minitest/autorun"
require_relative "isbn.rb"

class ISBN_Test < Minitest::Test
  def test_int_is_int
    assert_equal(1.class, Integer)
  end

  def test_isbn10_length_check_true
    assert_equal(true, isbn10("123456789X"))
  end

  def test_isbn10_length_check_false1
    assert_equal(false, isbn10("123"))
  end
  def test_isbn10_length_check_false1
    assert_equal(false, isbn10("123456789ABCDE"))
  end

  def test_isbnmultiplydigits_actually_multiplies1
    assert_equal([1,4,9,16,25,36,49,64,81,0], isbn_multiply_digits("1234567890"))
  end

  def test_isbnmultiplydigits_actually_multiplies2
    assert_equal([2,2,9,20,20,36,56,56,81,0], isbn_multiply_digits("2135468790"))
  end

end
