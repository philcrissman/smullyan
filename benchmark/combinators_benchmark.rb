# frozen_string_literal: true

require 'benchmark/ips'
require_relative '../lib/smullyan'

# Test functions
identity = ->(x) { x }
double = ->(x) { x * 2 }
add_one = ->(x) { x + 1 }
const_42 = ->(_x) { 42 }

puts "Benchmarking Combinator Implementations"
puts "=" * 50
puts

# Note: I combinator doesn't have a direct implementation since it's already minimal

# Benchmark B combinator
puts "B combinator (Bluebird - composition):"
Benchmark.ips do |x|
  x.report("B (derived)") do
    Smullyan::Birds::B.call(double).call(add_one).call(5)
  end

  x.report("B_direct") do
    Smullyan::Birds::B_direct.call(double).call(add_one).call(5)
  end

  x.compare!
end
puts

# Benchmark C combinator
puts "C combinator (Cardinal - flip):"
Benchmark.ips do |x|
  subtract = ->(x) { ->(y) { x - y } }

  x.report("C (derived)") do
    Smullyan::Birds::C.call(subtract).call(10).call(3)
  end

  x.report("C_direct") do
    Smullyan::Birds::C_direct.call(subtract).call(10).call(3)
  end

  x.compare!
end
puts

# Benchmark W combinator
puts "W combinator (Warbler - duplication):"
Benchmark.ips do |x|
  # W needs a function that can take itself as argument
  pair = ->(x) { ->(y) { [x, y] } }
  
  x.report("W (derived)") do
    Smullyan::Birds::W.call(pair).call(21)
  end

  x.report("W_direct") do
    Smullyan::Birds::W_direct.call(pair).call(21)
  end

  x.compare!
end
puts

# Benchmark M combinator
puts "M combinator (Mockingbird - self-application):"
Benchmark.ips do |x|
  x.report("M (derived)") do
    Smullyan::Birds::M.call(const_42)
  end

  x.report("M_direct") do
    Smullyan::Birds::M_direct.call(const_42)
  end

  x.compare!
end
puts

# Benchmark L combinator
puts "L combinator (Lark):"
Benchmark.ips do |x|
  x.report("L (derived)") do
    Smullyan::Birds::L.call(identity).call(const_42)
  end

  x.report("L_direct") do
    Smullyan::Birds::L_direct.call(identity).call(const_42)
  end

  x.compare!
end
puts

# Complex composition benchmark
puts "Complex composition (B B B pattern):"
Benchmark.ips do |x|
  triple = ->(x) { x * 3 }
  
  x.report("B (derived) composed") do
    b = Smullyan::Birds::B
    b.call(b.call(triple).call(double)).call(add_one).call(2)
  end

  x.report("B_direct composed") do
    b = Smullyan::Birds::B_direct
    b.call(b.call(triple).call(double)).call(add_one).call(2)
  end

  x.compare!
end
puts

# Y combinator benchmark (careful - recursive!)
# Note: Y and Z don't have separate direct implementations since they're already optimized for Ruby
puts "Y combinator (limited recursion):"
Benchmark.ips do |x|
  # Simple recursive function that terminates quickly
  sum_to_n = ->(f) { ->(n) { n <= 0 ? 0 : n + f.call(n - 1) } }

  x.report("Y combinator") do
    Smullyan::Birds::Y.call(sum_to_n).call(10)
  end

  x.report("Z combinator") do
    Smullyan::Birds::Z.call(sum_to_n).call(10)
  end

  x.compare!
end