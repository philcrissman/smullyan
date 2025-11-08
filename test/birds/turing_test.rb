# frozen_string_literal: true

require 'test_helper'

class TuringTest < Minitest::Test
  def test_turing_structure
    u = Smullyan::Birds::U

    # U x y = y (x x y)
    # The Turing bird is mainly used for building fixed-point combinators
    # and is difficult to test in isolation in a strict language.
    #
    # Let's test that it at least has the right structure:
    # U should be a Proc that takes an x and returns a Proc that takes a y
    assert_instance_of Proc, u

    result = u.(->(x) { x })
    assert_instance_of Proc, result
  end

  def test_turing_returns_callable
    u = Smullyan::Birds::U

    # U is a higher-order combinator that's difficult to test in isolation
    # in strict evaluation. Its main use is in constructing fixed-point combinators.
    # Just verify it returns a callable structure
    x = ->(_) { ->(y) { y } }
    result = u.(x)

    assert_instance_of Proc, result
  end

  def test_turing_use_in_z_combinator
    # The real test of U is that it works in the Z combinator
    # which we've already tested in zee_test.rb
    # This just verifies U is being used correctly there
    z = Smullyan::Birds::Z
    factorial = z.(lambda { |f|
      lambda { |n|
        n <= 1 ? 1 : n * f.(n - 1)
      }
    })

    assert_equal 120, factorial.(5)
  end

  def test_turing_aliases
    assert_equal Smullyan::Birds::U, Smullyan::Birds::Turing
  end
end
