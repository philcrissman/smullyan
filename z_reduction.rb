#!/usr/bin/env ruby
# frozen_string_literal: true

# Manual step-by-step reduction of Z = BU(CBQ)
# to understand why it doesn't work in strict evaluation

require_relative 'lib/smullyan'

puts "=" * 70
puts "MANUAL REDUCTION OF Z = BU(CBQ)"
puts "=" * 70
puts

# Combinator definitions:
puts "Combinator definitions:"
puts "  B x y z = x (y z)         - composition"
puts "  C x y z = x z y           - flip"
puts "  Q x y z = y (x z)         - forward composition (Queer bird)"
puts "  U x y = y (x x y)         - Turing bird"
puts
puts "Direct Z definition:"
puts "  Z f = (λx.f (λv.x x v)) (λx.f (λv.x x v))"
puts
puts "-" * 70

# Step-by-step reduction
puts "STEP-BY-STEP REDUCTION:"
puts
puts "Z = BU(CBQ)"
puts "Z = B U (C B Q)"
puts
puts "Apply Z to f:"
puts "  Z f = B U (C B Q) f"
puts "      = U ((C B Q) f)           [by B x y z = x (y z)]"
puts
puts "Now reduce (C B Q) f:"
puts "  C B Q f = B f Q               [by C x y z = x z y]"
puts
puts "So:"
puts "  Z f = U (B f Q)"
puts
puts "Expand U (B f Q):"
puts "  U x y = y (x x y)"
puts "  U (B f Q) = λy. y ((B f Q) (B f Q) y)"
puts
puts "So Z f is a function waiting for argument y (or n in factorial case)"
puts
puts "-" * 70
puts "COMPUTING (B f Q) (B f Q) y:"
puts
puts "  (B f Q) (B f Q) y"
puts "  = B f Q (B f Q) y            [apply first B f Q]"
puts "  = f (Q (B f Q)) y            [by B x y z = x (y z)]"
puts "  = f (Q (B f Q) y)            [function application]"
puts
puts "Now compute Q (B f Q) y:"
puts "  Q x y z = y (x z)"
puts "  Q (B f Q) y = λz. y ((B f Q) z)"
puts
puts "So:"
puts "  (B f Q) (B f Q) y = f (λz. y ((B f Q) z))"
puts
puts "-" * 70
puts "FINAL FORM:"
puts
puts "  Z f y = y ((B f Q) (B f Q) y)"
puts "        = y (f (λz. y ((B f Q) z)))"
puts
puts "Hmm, this doesn't look right..."
puts "Let me trace through with actual execution:"
puts
puts "=" * 70

# Now let's trace through with actual Ruby code
b = Smullyan::Birds::B
c = Smullyan::Birds::C
q = Smullyan::Birds::Q
u = Smullyan::Birds::U

# Simple test function
test_f = lambda { |rec|
  puts "    f called with rec=#{rec.class}"
  lambda { |n|
    puts "      inner lambda called with n=#{n.inspect}"
    if n <= 1
      1
    else
      puts "      about to call rec.(#{n - 1})"
      n * rec.(n - 1)
    end
  }
}

puts "ACTUAL EXECUTION TRACE:"
puts
puts "Computing Z = BU(CBQ):"
z_formula = b.(u).(c.(b).(q))
puts "  Z computed successfully"
puts

puts "Computing Z(test_f):"
begin
  factorial = z_formula.(test_f)
  puts "  Got factorial function: #{factorial.class}"
  puts

  puts "Computing factorial(3):"
  result = factorial.(3)
  puts "  Result: #{result}"
rescue => e
  puts "  ERROR: #{e.class}: #{e.message}"
  puts "  Location: #{e.backtrace.first}"
end
