# frozen_string_literal: true

require 'test_helper'

class FinchTest < Minitest::Test
    def test_finch_switches_first_and_third_arguments
        finch = Smullyan::Birds::Finch
    
        # Finch f g x = x g f
        subtract = ->(x) { ->(y) { x - y } }
        assert_equal -5, subtract.call(5).call(10)
        result = finch.call(5).call(10).call(subtract)
        assert_equal 5, result

        less_than = ->(a) { ->(b) { a < b } }
        assert less_than.(3).(5)
        refute finch.call(3).call(5).call(less_than)
    end
end