# frozen_string_literal: true

require 'test_helper'

class IdentityTest < Minitest::Test
  def test_identity_returns_its_argument
    identity = Smullyan::Birds::Identity

    assert_equal 42, identity.(42)
    assert_equal 'hello', identity.('hello')
    assert_equal [1, 2, 3], identity.([1, 2, 3])
    assert_equal({ a: 1 }, identity.({ a: 1 }))
  end

  def test_i_combinator_alias
    i = Smullyan::Birds::I

    assert_equal 42, i.(42)
    assert_equal 'hello', i.('hello')
  end

  def test_idiot_bird_alias
    idiot = Smullyan::Birds::Idiot

    assert_equal 42, idiot.(42)
    assert_equal 'test', idiot.('test')
  end

  def test_all_identity_aliases_are_equal
    assert_equal Smullyan::Birds::Identity, Smullyan::Birds::I
    assert_equal Smullyan::Birds::Identity, Smullyan::Birds::Idiot
    assert_equal Smullyan::Birds::I, Smullyan::Birds::Idiot
  end

  def test_identity_with_functions
    identity = Smullyan::Birds::Identity
    double = ->(x) { x * 2 }

    # Identity should return the function itself
    result = identity.(double)
    assert_equal double, result
    assert_equal 10, result.(5)
  end

  def test_identity_is_idempotent
    identity = Smullyan::Birds::Identity

    # Applying identity multiple times should have the same effect
    assert_equal 42, identity.(identity.(identity.(42)))
  end
end
