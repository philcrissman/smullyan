# frozen_string_literal: true

require 'test_helper'

class QueerTest < Minitest::Test
  def test_queer_forward_composition
    q = Smullyan::Birds::Q
    inc = ->(x) { x + 1 }
    double = ->(x) { x * 2 }

    # Q x y z = y (x z)
    # So Q(inc)(double)(5) = double(inc(5)) = double(6) = 12
    assert_equal 12, q.(inc).(double).(5)
  end

  def test_queer_string_operations
    q = Smullyan::Birds::Q
    upcase = ->(s) { s.upcase }
    reverse = ->(s) { s.reverse }

    # Q(upcase)(reverse)("hello") = reverse(upcase("hello")) = reverse("HELLO") = "OLLEH"
    assert_equal 'OLLEH', q.(upcase).(reverse).('hello')
  end

  def test_queer_composition_chain
    q = Smullyan::Birds::Q
    add_one = ->(x) { x + 1 }
    times_three = ->(x) { x * 3 }

    # Q(add_one)(times_three)(4) = times_three(add_one(4)) = times_three(5) = 15
    assert_equal 15, q.(add_one).(times_three).(4)
  end

  def test_queer_aliases
    assert_equal Smullyan::Birds::Q, Smullyan::Birds::Queer
  end
end
