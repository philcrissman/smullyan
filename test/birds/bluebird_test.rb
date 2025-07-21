# frozen_string_literal: true

require 'test_helper'

class BluebirdTest < Minitest::Test
  def test_bluebird_composition
    bluebird = Smullyan::Birds::Bluebird

    # Test function composition: B f g x = f (g x)
    double = ->(x) { x * 2 }
    increment = ->(x) { x + 1 }

    # B double increment 5 = double (increment 5) = double 6 = 12
    composed = bluebird.(double).(increment)
    assert_equal 12, composed.(5)
  end

  def test_b_combinator_alias
    b = Smullyan::Birds::B

    square = ->(x) { x * x }
    negate = lambda(&:-@)

    # B square negate 3 = square (negate 3) = square (-3) = 9
    composed = b.(square).(negate)
    assert_equal 9, composed.(3)
  end

  def test_bluebird_alias_equals_b
    assert_equal Smullyan::Birds::Bluebird, Smullyan::Birds::B
  end

  def test_bluebird_derived_equals_direct
    b = Smullyan::Birds::B
    b_direct = Smullyan::Birds::B_direct

    # Test that derived B behaves same as direct implementation
    square = ->(x) { x * x }
    negate = lambda(&:-@)

    assert_equal b.(square).(negate).(3),
                 b_direct.(square).(negate).(3)
  end

  def test_bluebird_with_strings
    b = Smullyan::Birds::B

    upcase = lambda(&:upcase)
    reverse = lambda(&:reverse)

    # B upcase reverse "hello" = upcase (reverse "hello") = upcase "olleh" = "OLLEH"
    composed = b.(upcase).(reverse)
    assert_equal 'OLLEH', composed.('hello')
  end

  # rubocop:disable Metrics/AbcSize
  def test_bluebird_associativity
    b = Smullyan::Birds::B

    add_one = ->(x) { x + 1 }
    double = ->(x) { x * 2 }
    square = ->(x) { x * x }

    # Compose three functions: square ∘ double ∘ add_one
    # (3 + 1) * 2 = 8, then 8² = 64
    composed1 = b.(square).(b.(double).(add_one))
    assert_equal 64, composed1.(3)

    # Same result with different grouping
    composed2 = b.(b.(square).(double)).(add_one)
    assert_equal 64, composed2.(3)
  end
  # rubocop:enable Metrics/AbcSize

  def test_bluebird_creates_pipeline
    b = Smullyan::Birds::B

    # Create a pipeline of transformations
    trim = lambda(&:strip)
    downcase = lambda(&:downcase)
    reverse = lambda(&:reverse)

    # Pipeline: trim -> downcase -> reverse
    pipeline = b.(reverse).(b.(downcase).(trim))

    assert_equal 'olleh', pipeline.('  HELLO  ')
  end

  def test_bluebird_is_curried
    bluebird = Smullyan::Birds::Bluebird

    # Can be called step by step
    step1 = bluebird.(->(x) { x * 2 })
    assert_instance_of Proc, step1

    step2 = step1.(->(x) { x + 1 })
    assert_instance_of Proc, step2

    step3 = step2.(5)
    assert_equal 12, step3
  end
end
