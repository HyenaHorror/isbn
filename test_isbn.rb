require "minitest/autorun"
require_relative "isbn.rb"

class ISBN_Test < Minitest::Test
  def test_int_is_int
    assert_equal(1.class, Integer)
  end

  def test_isbn10_length_check_true
    assert_equal(true, isbn10("0471958697"))
  end

  def test_isbn10_length_check_false1
    assert_equal(false, isbn10("123"))
  end
  def test_isbn10_length_check_false1
    assert_equal(false, isbn10("123456789ABCDE"))
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

  def test_account_for_x1_pass
    assert_equal([1,4,9,16,25,36,49,64,81,10], convert_input_to_array("123456789X"))
  end
  def test_account_for_x2_pass
    assert_equal([1,4,9,16,25,10], convert_input_to_array("12345X"))
  end
  def test_account_for_x3_pass
    assert_equal([1,4,9,16,25,36,49,64,81,0,11,24,10], convert_input_to_array("123456789012X"))
  end
  def test_account_for_x_no_x_1
    assert_equal([1,4,9,16,25,36,49,64,81,7], convert_input_to_array("1234567897"))
  end
  def test_account_for_x_no_x2
    assert_equal([1,4,9,16,25,2], convert_input_to_array("123452"))
  end

  def test_isbn13_length_check_pass1
    assert_equal(true, isbn13("9780470059029"))
  end
  def test_isbn13_length_check_pass2
    assert_equal(true, isbn13("978 1 630 08780 7"))
  end
  def test_isbn13_length_check_fail1
    assert_equal(false, isbn13("12345"))
  end
  def test_isbn13_length_check_fail2
    assert_equal(false, isbn13("0471958697"))
  end

  def test_convertisbn13_1
    assert_equal([1,6,3,12,5,18,7,24,9,0,1,6,3], convert_input_to_array_isbn13("1234567890123"))
  end

  def test_convertisbn13_2
    assert_equal([1,9,1,9,1,9,1,9,1,9,1,9,1], convert_input_to_array_isbn13("1313131313131"))
  end

  def test_convertisbn13_3
    assert_equal([9,21,8,0,4,21,0,0,5,27,0,6,9], convert_input_to_array_isbn13("9780470059029"))
  end
  def test_isbn13_checksum_pass1
    input = remove_extra_characters("978-1-4028-9462-6")
    assert_equal(true, checksum_isbn13(convert_input_to_array_isbn13(input)))
  end
  def test_isbn13_checksum_pass2
    input = remove_extra_characters("978 1 630 08780 7")
    assert_equal(true, checksum_isbn13(convert_input_to_array_isbn13(input)))
  end
  def test_isbn13_checksum_pass3
    assert_equal(true, checksum_isbn13(convert_input_to_array_isbn13("9780470059029")))
  end
end
