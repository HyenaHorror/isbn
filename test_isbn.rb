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
end
