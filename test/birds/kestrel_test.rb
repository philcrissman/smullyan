# frozen_string_literal: true

require 'test_helper'

class KestrelTest < Minitest::Test
  def test_kestrel_returns_first_argument
    kestrel = Smullyan::Birds::Kestrel

    assert_equal 42, kestrel.(42).(99)
    assert_equal 'first', kestrel.('first').('second')
    assert_equal [1, 2, 3], kestrel.([1, 2, 3]).([4, 5, 6])
  end

  def test_k_combinator_alias
    k = Smullyan::Birds::K

    assert_equal 42, k.(42).(99)
    assert_equal 'first', k.('first').('second')
  end

  def test_kestrel_alias_equals_k
    assert_equal Smullyan::Birds::Kestrel, Smullyan::Birds::K
  end

  def test_kestrel_with_functions
    kestrel = Smullyan::Birds::Kestrel
    double = ->(x) { x * 2 }
    increment = ->(x) { x + 1 }

    # Kestrel returns the first function, ignoring the second
    result = kestrel.(double).(increment)
    assert_equal double, result
    assert_equal 10, result.(5)
  end

  def test_kestrel_creates_constant_function
    kestrel = Smullyan::Birds::Kestrel
    const_forty_two = kestrel.(42)

    # const_forty_two always returns 42, regardless of input
    assert_equal 42, const_forty_two.(1)
    assert_equal 42, const_forty_two.('anything')
    assert_equal 42, const_forty_two.(nil)
    assert_equal 42, const_forty_two.([1, 2, 3])
  end

  def test_kestrel_is_curried
    kestrel = Smullyan::Birds::Kestrel

    # Can be called step by step
    step1 = kestrel.('hello')
    assert_instance_of Proc, step1

    step2 = step1.('world')
    assert_equal 'hello', step2
  end
end
