# frozen_string_literal: true

require 'test_helper'

class CardinalTest < Minitest::Test
  def test_cardinal_flips_arguments
    cardinal = Smullyan::Birds::Cardinal

    # Test argument flipping: C f x y = f y x
    subtract = ->(x) { ->(y) { x - y } }

    # C subtract 5 3 = subtract 3 5 = 3 - 5 = -2
    flipped = cardinal.call(subtract)
    assert_equal(-2, flipped.call(5).call(3))

    # Without C: subtract 5 3 = 5 - 3 = 2
    assert_equal 2, subtract.call(5).call(3)
  end

  def test_c_combinator_alias
    c = Smullyan::Birds::C

    divide = ->(x) { ->(y) { x.to_f / y } }
    # C divide 10 2 = divide 2 10 = 2.0 / 10 = 0.2
    assert_equal 0.2, c.call(divide).call(10).call(2)
  end

  def test_cardinal_alias_equals_c
    assert_equal Smullyan::Birds::Cardinal, Smullyan::Birds::C
  end

  def test_cardinal_derived_equals_direct
    c = Smullyan::Birds::C
    c_direct = Smullyan::Birds::C_direct

    # Test that derived C behaves same as direct implementation
    divide = ->(x) { ->(y) { x.to_f / y } }

    assert_equal c.call(divide).call(10).call(2),
                 c_direct.call(divide).call(10).call(2)
  end

  def test_cardinal_with_strings
    c = Smullyan::Birds::C

    concat = ->(x) { ->(y) { x + y } }

    # C concat "world" "hello" = concat "hello" "world" = "helloworld"
    flipped_concat = c.call(concat)
    assert_equal 'helloworld', flipped_concat.call('world').call('hello')
  end

  def test_cardinal_practical_use
    c = Smullyan::Birds::C
    k = Smullyan::Birds::K

    # C K x y = K y x = y (demonstrates how C can be used to select second argument)
    second = c.call(k)
    assert_equal 'second', second.call('first').call('second')
    assert_equal 42, second.call(99).call(42)
  end

  def test_cardinal_is_curried
    cardinal = Smullyan::Birds::Cardinal

    # Can be called step by step
    step1 = cardinal.call(->(x) { ->(y) { x - y } })
    assert_instance_of Proc, step1

    step2 = step1.call(10)
    assert_instance_of Proc, step2

    step3 = step2.call(3)
    assert_equal(-7, step3) # 3 - 10 = -7
  end
end
