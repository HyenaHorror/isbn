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
    assert_equal([1,4,9,16,25,36,49,64,81,0], isbn_multiply_digits([1,2,3,4,5,6,7,8,9,0]))
  end

  def test_isbnmultiplydigits_actually_multiplies2
    assert_equal([2,2,9,20,20,36,56,56,81,0], isbn_multiply_digits([2,1,3,5,4,6,8,7,9,0]))
  end
  def test_isbn10_checksum_pass
    assert_equal(true, isbn10("0471958697"))
  end
  def test_isbn10_checksum_fail
    assert_equal(false, isbn10("1212121212"))
  end

  def test_remove_extra_characters_spaces
    assert_equal("0321146530", remove_extra_characters("0 321 14653 0"))
  end

  def test_remove_extra_characters_hyphens
    assert_equal("0321146530", remove_extra_characters("0-321-14653-0"))
  end

end
