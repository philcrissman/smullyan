# frozen_string_literal: true

require 'test_helper'

class RobinTest < Minitest::Test
  def test_robin_rotates_arguments
    robin = Smullyan::Birds::Robin

    subtract = ->(x) { ->(y) { x - y } }
    
    assert_equal 2, robin.call(3).call(subtract).call(5)
  end

  def test_robin_can_compose_cardinal
    robin = Smullyan::Birds::Robin

    c_from_robins = robin.(robin).(robin)
    cardinal = Smullyan::Birds::Cardinal

    subtract = ->(x) { ->(y) { x - y } }

    assert_equal (-2), c_from_robins.(subtract).(5).(3)
    assert_equal (-2), cardinal.(subtract).(5).(3)
  end
end