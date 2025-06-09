# frozen_string_literal: true

require 'test_helper'

class SmullyanTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Smullyan::VERSION
  end

  def test_all_birds_still_available
    # Test that all birds are still accessible after modularization
    assert_instance_of Proc, Smullyan::Birds::Identity
    assert_instance_of Proc, Smullyan::Birds::Kestrel
    assert_instance_of Proc, Smullyan::Birds::Starling
    assert_instance_of Proc, Smullyan::Birds::Bluebird
    assert_instance_of Proc, Smullyan::Birds::Cardinal
    assert_instance_of Proc, Smullyan::Birds::Warbler
    assert_instance_of Proc, Smullyan::Birds::Mockingbird
    assert_instance_of Proc, Smullyan::Birds::Why
  end

  def test_bird_names_functional
    # Test that bird names work functionally
    kestrel = Smullyan::Birds::Kestrel
    mockingbird = Smullyan::Birds::Mockingbird
    bluebird = Smullyan::Birds::Bluebird

    # Kestrel returns first argument
    assert_equal 42, kestrel.call(42).call(99)

    # Mockingbird applies function to itself
    const_func = ->(_x) { 99 }
    assert_equal 99, mockingbird.call(const_func)

    # Bluebird composes functions
    inc = ->(x) { x + 1 }
    double = ->(x) { x * 2 }
    assert_equal 12, bluebird.call(double).call(inc).call(5)
  end
end
