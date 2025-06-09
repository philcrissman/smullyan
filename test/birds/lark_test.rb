# frozen_string_literal: true

require 'test_helper'

class LarkTest < Minitest::Test
  def test_lark_applies_first_to_second_self_applied
    lark = Smullyan::Birds::Lark

    # L x y = x (y y)
    # Test with a simple function
    const_forty_two = ->(_x) { 42 }
    identity = ->(x) { x }

    # L const_forty_two identity = const_forty_two (identity identity) = const_forty_two identity = 42
    result = lark.call(const_forty_two).call(identity)
    assert_equal 42, result
  end

  def test_l_combinator_alias
    l = Smullyan::Birds::L

    # Test with a counting function to verify self-application
    counter = 0
    counting_fn = lambda { |x|
      counter += 1
      x
    }
    first = ->(x) { x }

    # L first counting_fn = first (counting_fn counting_fn)
    result = l.call(first).call(counting_fn)
    assert_equal counting_fn, result
    assert_equal 1, counter # counting_fn was called once (self-applied)
  end

  def test_lark_alias_equals_l
    assert_equal Smullyan::Birds::Lark, Smullyan::Birds::L
  end

  def test_lark_derived_equals_direct
    l = Smullyan::Birds::L
    l_direct = Smullyan::Birds::L_direct

    # Test that derived L behaves same as direct implementation
    double = ->(x) { x * 2 }
    const_five = ->(_x) { 5 }

    assert_equal l.call(double).call(const_five),
                 l_direct.call(double).call(const_five)
  end

  def test_lark_with_arithmetic
    l = Smullyan::Birds::L

    # Test with a simple self-application scenario
    const_forty_two = ->(_x) { 42 }
    identity = ->(x) { x }

    # L identity const_forty_two = identity (const_forty_two const_forty_two) = identity 42 = 42
    result = l.call(identity).call(const_forty_two)
    assert_equal 42, result
  end

  def test_lark_creates_omega_variant
    l = Smullyan::Birds::L
    i = Smullyan::Birds::I

    # L I creates a function that self-applies its argument
    # L I x = I (x x) = x x
    self_apply = l.call(i)

    # Test with identity - should return identity
    assert_equal i, self_apply.call(i)
  end

  def test_lark_is_curried
    lark = Smullyan::Birds::Lark

    # Can be called step by step
    step1 = lark.call(->(x) { x })
    assert_instance_of Proc, step1

    step2 = step1.call(->(_x) { 42 })
    assert_equal 42, step2
  end

  def test_lark_practical_example
    l = Smullyan::Birds::L

    # Create a function that extracts a value from self-application
    extractor = ->(result) { result.is_a?(Integer) ? result : 0 }
    supplier = ->(_x) { 99 } # Always returns 99

    # L extractor supplier = extractor (supplier supplier) = extractor 99 = 99
    result = l.call(extractor).call(supplier)
    assert_equal 99, result
  end
end
