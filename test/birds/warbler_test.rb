# frozen_string_literal: true

require 'test_helper'

class WarblerTest < Minitest::Test
  def test_warbler_duplication
    w = Smullyan::Birds::W

    # Test argument duplication: W f x = f x x
    multiply = ->(x) { ->(y) { x * y } }

    # W multiply 5 = multiply 5 5 = 25
    square = w.(multiply)
    assert_equal 25, square.(5)
    assert_equal 9, square.(3)
  end

  def test_warbler_derived_equals_direct
    w = Smullyan::Birds::W
    w_direct = Smullyan::Birds::W_direct

    # Test that derived W behaves same as direct implementation
    add = ->(x) { ->(y) { x + y } }

    assert_equal w.(add).(7),
                 w_direct.(add).(7)
  end

  def test_warbler_with_strings
    w = Smullyan::Birds::W

    concat = ->(x) { ->(y) { x + y } }

    # W concat "hi" = concat "hi" "hi" = "hihi"
    double_string = w.(concat)
    assert_equal 'hihi', double_string.('hi')
    assert_equal 'testtest', double_string.('test')
  end

  def test_warbler_practical_use
    w = Smullyan::Birds::W
    k = Smullyan::Birds::K

    # W K x = K x x = x (another way to derive identity)
    identity_via_w = w.(k)
    assert_equal 42, identity_via_w.(42)
    assert_equal 'hello', identity_via_w.('hello')
  end
end
