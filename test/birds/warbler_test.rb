# frozen_string_literal: true

require "test_helper"

class WarblerTest < Minitest::Test
  def test_warbler_duplication
    w = Smullyan::Birds::W
    
    # Test argument duplication: W f x = f x x
    multiply = ->(x) { ->(y) { x * y } }
    
    # W multiply 5 = multiply 5 5 = 25
    square = w.call(multiply)
    assert_equal 25, square.call(5)
    assert_equal 9, square.call(3)
  end

  def test_warbler_derived_equals_direct
    w = Smullyan::Birds::W
    w_direct = Smullyan::Birds::W_direct
    
    # Test that derived W behaves same as direct implementation
    add = ->(x) { ->(y) { x + y } }
    
    assert_equal w.call(add).call(7),
                 w_direct.call(add).call(7)
  end

  def test_warbler_with_strings
    w = Smullyan::Birds::W
    
    concat = ->(x) { ->(y) { x + y } }
    
    # W concat "hi" = concat "hi" "hi" = "hihi"
    double_string = w.call(concat)
    assert_equal "hihi", double_string.call("hi")
    assert_equal "testtest", double_string.call("test")
  end

  def test_warbler_practical_use
    w = Smullyan::Birds::W
    k = Smullyan::Birds::K
    
    # W K x = K x x = x (another way to derive identity)
    identity_via_w = w.call(k)
    assert_equal 42, identity_via_w.call(42)
    assert_equal "hello", identity_via_w.call("hello")
  end
end