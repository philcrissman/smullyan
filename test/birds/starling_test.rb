# frozen_string_literal: true

require 'test_helper'

class StarlingTest < Minitest::Test
  def test_starling_distributes_third_argument
    starling = Smullyan::Birds::Starling

    # S f g x = f x (g x)
    # Let's use functions that take the result of g x as their second argument
    k = Smullyan::Birds::K
    i = Smullyan::Birds::I

    # S K I x = K x (I x) = K x x = x
    result = starling.call(k).call(i).call(42)
    assert_equal 42, result
  end

  def test_s_combinator_alias
    s = Smullyan::Birds::S
    k = Smullyan::Birds::K

    # S K K is the identity function
    skk = s.call(k).call(k)
    assert_equal 42, skk.call(42)
  end

  def test_starling_alias_equals_s
    assert_equal Smullyan::Birds::Starling, Smullyan::Birds::S
  end

  def test_starling_creates_identity_with_k
    s = Smullyan::Birds::S
    k = Smullyan::Birds::K

    # S K K x = K x (K x) = x
    identity = s.call(k).call(k)

    assert_equal 42, identity.call(42)
    assert_equal 'hello', identity.call('hello')
    assert_equal [1, 2, 3], identity.call([1, 2, 3])
  end

  def test_starling_with_simple_functions
    s = Smullyan::Birds::S
    k = Smullyan::Birds::K

    # Let's create some test functions
    const_forty_two = k.call(42) # Always returns 42
    double = ->(x) { x * 2 }

    # S K double x = K x (double x) = x
    # This shows that S K f is the identity for any f
    result = s.call(k).call(double).call(5)
    assert_equal 5, result

    # Another example: S (K const_forty_two) I x = K const_forty_two x (I x) = const_forty_two
    result2 = s.call(k.call(const_forty_two)).call(Smullyan::Birds::I).call('anything')
    assert_equal 42, result2
  end

  def test_starling_is_curried
    starling = Smullyan::Birds::Starling
    k = Smullyan::Birds::K
    i = Smullyan::Birds::I

    # Can be called step by step
    step1 = starling.call(k)
    assert_instance_of Proc, step1

    step2 = step1.call(i)
    assert_instance_of Proc, step2

    step3 = step2.call(42)
    assert_equal 42, step3
  end

  # rubocop:disable Metrics/AbcSize
  def test_average_with_s3
    b = Smullyan::Birds::B
    starling = Smullyan::Birds::Starling
    s3 = ->(f) { ->(g) { ->(h) { starling.call(b.call(f).call(g)).call(h) } } }

    div = ->(num) { ->(denom) { num / denom.to_f } }
    sum = lambda(&:sum)
    length = lambda(&:length)

    average = s3.call(div).call(sum).call(length)

    # Average of [1, 2, 3] should be (1 + 2 + 3) / 3 = 2.0
    result = average.call([1, 2, 3])
    assert_equal 2.0, result
  end
  # rubocop:enable Metrics/AbcSize
end
