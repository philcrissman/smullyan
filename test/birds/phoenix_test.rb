# frozen_string_literal: true

require 'test_helper'

class PhoenixTest < Minitest::Test
  def test_phoenix_applies_functions_correctly
    # phoenix is essentially `fork` from APL
    # phi xyzw = z(yw)(zw)

    # phi is fork from APL, etc.
    phi = Smullyan::Birds::Phoenix

    div = ->(x){ ->(y) { x / y }}
    sum = ->(list) { list.sum }
    len = ->(list) { list.length }

    avg = phi.(div).(sum).(len)

    assert_equal 4.0, avg.([1.0,7.0])
  end

  def test_phoenix_direct
    phi = Smullyan::Birds::Phoenix_direct

    div = ->(x){ ->(y) { x / y }}
    sum = ->(list) { list.sum }
    len = ->(list) { list.length }

    avg = phi.(div).(sum).(len)

    assert_equal 4.0, avg.([1.0,7.0])
  end
end