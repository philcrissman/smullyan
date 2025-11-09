#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/smullyan'

puts "ANALYSIS: Why BU(CBQ) has an extra layer"
puts "=" * 70
puts

# The issue: the derived Z returns a function when it should return a value
# Let's see if we can fix it by adding an extra call

b = Smullyan::Birds::B
c = Smullyan::Birds::C
q = Smullyan::Birds::Q
u = Smullyan::Birds::U

z_derived = b.(u).(c.(b).(q))

# Simple factorial
f = lambda { |rec|
  lambda { |n|
    n <= 1 ? 1 : n * rec.(n - 1)
  }
}

puts "Test 1: Original derived Z (fails)"
puts "-" * 40
begin
  factorial = z_derived.(f)
  result = factorial.(5)
  puts "Result: #{result}"
rescue => e
  puts "Error: #{e.message}"
end
puts

puts "Test 2: What if rec needs to be called TWICE?"
puts "-" * 40
# Let's modify f to call rec twice
f2 = lambda { |rec|
  lambda { |n|
    if n <= 1
      1
    else
      # Call rec twice: rec.(n-1) returns a function, so call it
      rec_fn = rec.(n - 1)
      if rec_fn.is_a?(Proc)
        # It's a function, call it with... what?
        # Let's try calling it with n-1 again?
        result = rec_fn.(n - 1)
        n * result
      else
        n * rec_fn
      end
    end
  }
}

begin
  factorial2 = z_derived.(f2)
  result2 = factorial2.(5)
  puts "Result: #{result2}"
rescue => e
  puts "Error: #{e.message}"
  puts e.backtrace.first
end
puts

puts "Test 3: Understanding what Q produces"
puts "-" * 40
puts "In the derivation: Z f y = y (f (λz. y ((B f Q) z)))"
puts
puts "The rec that f receives should be: λz. y ((B f Q) z)"
puts "When we call rec.(n-1), we should get: y ((B f Q) (n-1))"
puts
puts "But y is the NUMBER we're passing (the argument to factorial)"
puts "So we're trying to call: NUMBER ((B f Q) (n-1))"
puts "That's why it fails! y should be a function, not a number!"
puts

puts "This reveals the problem:"
puts "  In direct Z: rec = λv. x.(x).(v)"
puts "               This is a function ready to receive a number"
puts
puts "  In derived Z via BU(CBQ): rec has the wrong structure"
puts "               It expects its argument to be a FUNCTION, not a number"
puts

puts "=" * 70
puts "CONCLUSION: The formula Z = BU(CBQ) appears to be INCORRECT"
puts "or requires a different definition of Q than the Queer bird!"
puts "=" * 70
