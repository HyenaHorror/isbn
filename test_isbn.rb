require "minitest/autorun"
require_relative "isbn.rb"

class ISBN_Test < Minitest::Test
  def test_int_is_int
    assert_equal(1.class, Integer)
  end
end
