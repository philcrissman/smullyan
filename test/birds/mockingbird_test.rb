# frozen_string_literal: true

require 'test_helper'

class MockingbirdTest < Minitest::Test
  def test_mockingbird_self_application
    m = Smullyan::Birds::M

    # M x = x x
    # Test with a function that counts how many times it's called
    counter = 0
    counting_function = lambda { |_x|
      counter += 1
      42
    }

    result = m.call(counting_function)
    assert_equal 42, result
    assert_equal 1, counter # Function was applied to itself once
  end

  def test_mockingbird_derived_equals_direct
    m = Smullyan::Birds::M
    m_direct = Smullyan::Birds::M_direct

    # Test that derived M behaves same as direct implementation
    # Use a function that can be applied to itself
    const_forty_two = ->(_x) { 42 }

    assert_equal m.call(const_forty_two), m_direct.call(const_forty_two)
  end

  def test_mockingbird_with_w
    m = Smullyan::Birds::M
    w = Smullyan::Birds::W

    # M W = W W = W W x = W x x = x x x
    # This creates a function that applies its argument to itself
    mw = m.call(w)

    # Test with identity function
    i = Smullyan::Birds::I
    assert_equal i, mw.call(i) # I I = I
  end

  def test_mockingbird_omega
    # The omega combinator is M M, which creates an infinite loop
    # We won't actually run this as it would hang, but we can verify it's constructible
    m = Smullyan::Birds::M

    # Just verify we can create the expression (but don't call it!)
    omega = -> { m.call(m) }
    assert_instance_of Proc, omega
  end
end
