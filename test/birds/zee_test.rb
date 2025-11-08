# frozen_string_literal: true

require 'test_helper'

class ZeeTest < Minitest::Test
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def test_zee_factorial
    z = Smullyan::Birds::Z

    # Define factorial using Z combinator
    factorial = z.(lambda { |f|
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
  def test_zee_fibonacci
    z = Smullyan::Birds::Z

    # Define fibonacci using Z combinator
    fibonacci = z.(lambda { |f|
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

  def test_zee_sum
    z = Smullyan::Birds::Z

    # Define sum function for arrays using Z combinator
    sum = z.(lambda { |f|
      lambda { |arr|
        arr.empty? ? 0 : arr[0] + f.(arr[1..])
      }
    })

    assert_equal 0, sum.([])
    assert_equal 1, sum.([1])
    assert_equal 6, sum.([1, 2, 3])
    assert_equal 15, sum.([1, 2, 3, 4, 5])
  end

  def test_zee_aliases
    assert_equal Smullyan::Birds::Z, Smullyan::Birds::Zee
  end
end
