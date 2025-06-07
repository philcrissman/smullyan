# frozen_string_literal: true

require "test_helper"

class TestSki < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ski::VERSION
  end

  def test_i_combinator
    i = Ski::Combinators::I
    assert_equal 42, i.call(42)
    assert_equal "hello", i.call("hello")
  end

  def test_k_combinator
    k = Ski::Combinators::K
    assert_equal 42, k.call(42).call(99)
    assert_equal "first", k.call("first").call("second")
  end

  def test_s_combinator
    s = Ski::Combinators::S
    k = Ski::Combinators::K
    i = Ski::Combinators::I
    
    # S K K x = x (the identity function can be derived from S and K)
    skk = s.call(k).call(k)
    assert_equal 42, skk.call(42)
  end
end