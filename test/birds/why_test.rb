# frozen_string_literal: true

require 'test_helper'

class WhyTest < Minitest::Test
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def test_why_factorial
    y = Smullyan::Birds::Y

    # Define factorial using Y combinator
    factorial = y.(lambda { |f|
      lambda { |n|
        n <= 1 ? 1 : n * f.(n - 1)
      }
    })

    assert_equal 1, factorial.(0)
    assert_equal 1, factorial.(1)
    assert_equal 2, factorial.(2)
    assert_equal 6, factorial.(3)
    assert_equal 24, factorial.(4)
    assert_equal 120, factorial.(5)
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def test_why_fibonacci
    y = Smullyan::Birds::Y

    # Define fibonacci using Y combinator
    fibonacci = y.(lambda { |f|
      lambda { |n|
        n <= 1 ? n : f.(n - 1) + f.(n - 2)
      }
    })

    assert_equal 0, fibonacci.(0)
    assert_equal 1, fibonacci.(1)
    assert_equal 1, fibonacci.(2)
    assert_equal 2, fibonacci.(3)
    assert_equal 3, fibonacci.(4)
    assert_equal 5, fibonacci.(5)
    assert_equal 8, fibonacci.(6)
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def test_why_length
    y = Smullyan::Birds::Y

    # Define length function for arrays using Y combinator
    length = y.(lambda { |f|
      lambda { |arr|
        arr.empty? ? 0 : 1 + f.(arr[1..])
      }
    })

    assert_equal 0, length.([])
    assert_equal 1, length.([1])
    assert_equal 3, length.([1, 2, 3])
    assert_equal 5, length.(%w[a b c d e])
  end

  def test_why_aliases
    assert_equal Smullyan::Birds::Why, Smullyan::Birds::Y
    assert_equal Smullyan::Birds::Why, Smullyan::Birds::Sage
  end
end
