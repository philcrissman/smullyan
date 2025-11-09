#!/usr/bin/env ruby
# frozen_string_literal: true

# Systematic derivation: what must Q be for Z = BU(CBQ) to work?
#
# We know:
# - Z works: Z f = (λx. f (λv. x x v)) (λx. f (λv. x x v))
# - Y = BU(CBU) for lazy evaluation
# - Z = BU(CBQ) for strict evaluation
# - The only difference is U vs Q
#
# Therefore Q must be a variant of U that adds the delay needed for strict evaluation

require_relative 'lib/smullyan'

puts "DERIVING Q FROM THE REQUIREMENT THAT Z = BU(CBQ)"
puts "=" * 70
puts

puts "We know the working Z combinator:"
puts "  Z f = (λx. f (λv. x x v)) (λx. f (λv. x x v))"
puts

puts "We want: Z = BU(CBQ)"
puts "Which expands to: Z f = U (B f Q)"
puts

puts "U x y = y (x x y)"
puts "So: U (B f Q) = λy. y ((B f Q) (B f Q) y)"
puts

puts "For this to equal our working Z, we need:"
puts "  λy. y ((B f Q) (B f Q) y) = the result of applying Z to f"
puts

puts "But our Z doesn't take a y parameter directly!"
puts "It immediately self-applies and returns a function."
puts

puts "Let me try deriving Q differently..."
puts "-" * 70
puts

# Let's work backwards from what we need
puts "Working backwards:"
puts

puts "The direct Z internally creates: λv. x x v"
puts "This is the key delay mechanism."
puts

puts "U x y = y (x x y) - no delay"
puts "We need something that produces: y (λv. x x y v)"
puts

puts "Let's define Q as:"
puts "  Q x y = λv. y (x x y) v"
puts

# Test this Q
Q_hypothesis = ->(x) { ->(y) { ->(v) { y.(x.(x).(y)).(v) } } }

b = Smullyan::Birds::B
c = Smullyan::Birds::C
u = Smullyan::Birds::U

z_test = b.(u).(c.(b).(Q_hypothesis))

f = lambda { |rec|
  lambda { |n|
    n <= 1 ? 1 : n * rec.(n - 1)
  }
}

puts "Testing Q x y = λv. y (x x y) v:"
begin
  factorial = z_test.(f)
  result = factorial.(5)
  puts "  ✓ SUCCESS! factorial(5) = #{result}"
rescue => e
  puts "  ✗ FAILED: #{e.message}"
end
puts

# Try another definition
puts "Maybe Q is defined differently..."
puts "What if Q x y v = (y (x x y)) v  [with explicit parentheses]"
puts "This is the same as above, just clearer notation."
puts

# Or maybe it's simpler
puts "Or perhaps Q is just U with eta-expansion on the result?"
Q_eta = ->(x) { ->(y) { ->(v) { u.(x).(y).(v) } } }

z_test2 = b.(u).(c.(b).(Q_eta))

puts "Testing Q = eta-expanded U:"
begin
  factorial2 = z_test2.(f)
  result2 = factorial2.(5)
  puts "  ✓ SUCCESS! factorial(5) = #{result2}"
rescue => e
  puts "  ✗ FAILED: #{e.message}"
end
