# frozen_string_literal: true

require 'test_helper'

class WhyTest < Minitest::Test
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def test_why_factorial
    y = Smullyan::Birds::Y

    # Define factorial using Y combinator
    factorial = y.call(lambda { |f|
      lambda { |n|
        n <= 1 ? 1 : n * f.call(n - 1)
      }
    })

    assert_equal 1, factorial.call(0)
    assert_equal 1, factorial.call(1)
    assert_equal 2, factorial.call(2)
    assert_equal 6, factorial.call(3)
    assert_equal 24, factorial.call(4)
    assert_equal 120, factorial.call(5)
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def test_why_fibonacci
    y = Smullyan::Birds::Y

    # Define fibonacci using Y combinator
    fibonacci = y.call(lambda { |f|
      lambda { |n|
        n <= 1 ? n : f.call(n - 1) + f.call(n - 2)
      }
    })

    assert_equal 0, fibonacci.call(0)
    assert_equal 1, fibonacci.call(1)
    assert_equal 1, fibonacci.call(2)
    assert_equal 2, fibonacci.call(3)
    assert_equal 3, fibonacci.call(4)
    assert_equal 5, fibonacci.call(5)
    assert_equal 8, fibonacci.call(6)
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def test_why_length
    y = Smullyan::Birds::Y

    # Define length function for arrays using Y combinator
    length = y.call(lambda { |f|
      lambda { |arr|
        arr.empty? ? 0 : 1 + f.call(arr[1..])
      }
    })

    assert_equal 0, length.call([])
    assert_equal 1, length.call([1])
    assert_equal 3, length.call([1, 2, 3])
    assert_equal 5, length.call(%w[a b c d e])
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def test_z_combinator_equivalence
    y = Smullyan::Birds::Y
    z = Smullyan::Birds::Z

    # Both Y and Z should work the same for our use case
    sum_to_n_y = y.call(lambda { |f|
      lambda { |n|
        n <= 0 ? 0 : n + f.call(n - 1)
      }
    })

    sum_to_n_z = z.call(lambda { |f|
      lambda { |n|
        n <= 0 ? 0 : n + f.call(n - 1)
      }
    })

    assert_equal sum_to_n_y.call(10), sum_to_n_z.call(10)
    assert_equal 55, sum_to_n_y.call(10)
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def test_why_aliases
    assert_equal Smullyan::Birds::Why, Smullyan::Birds::Y
    assert_equal Smullyan::Birds::Why, Smullyan::Birds::Sage
  end
end
