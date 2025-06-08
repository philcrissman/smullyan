# frozen_string_literal: true

require "test_helper"

class KestrelTest < Minitest::Test
  def test_kestrel_returns_first_argument
    kestrel = Smullyan::Birds::Kestrel
    
    assert_equal 42, kestrel.call(42).call(99)
    assert_equal "first", kestrel.call("first").call("second")
    assert_equal [1, 2, 3], kestrel.call([1, 2, 3]).call([4, 5, 6])
  end
  
  def test_k_combinator_alias
    k = Smullyan::Birds::K
    
    assert_equal 42, k.call(42).call(99)
    assert_equal "first", k.call("first").call("second")
  end
  
  def test_kestrel_alias_equals_k
    assert_equal Smullyan::Birds::Kestrel, Smullyan::Birds::K
  end
  
  def test_kestrel_with_functions
    kestrel = Smullyan::Birds::Kestrel
    double = ->(x) { x * 2 }
    increment = ->(x) { x + 1 }
    
    # Kestrel returns the first function, ignoring the second
    result = kestrel.call(double).call(increment)
    assert_equal double, result
    assert_equal 10, result.call(5)
  end
  
  def test_kestrel_creates_constant_function
    kestrel = Smullyan::Birds::Kestrel
    const_42 = kestrel.call(42)
    
    # const_42 always returns 42, regardless of input
    assert_equal 42, const_42.call(1)
    assert_equal 42, const_42.call("anything")
    assert_equal 42, const_42.call(nil)
    assert_equal 42, const_42.call([1, 2, 3])
  end
  
  def test_kestrel_is_curried
    kestrel = Smullyan::Birds::Kestrel
    
    # Can be called step by step
    step1 = kestrel.call("hello")
    assert_instance_of Proc, step1
    
    step2 = step1.call("world")
    assert_equal "hello", step2
  end
end