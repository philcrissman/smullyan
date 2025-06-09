# frozen_string_literal: true

require 'benchmark/ips'
require_relative '../lib/smullyan'

# Test functions
identity = ->(x) { x }
double = ->(x) { x * 2 }
add_one = ->(x) { x + 1 }
const_42 = ->(_x) { 42 }

puts "Benchmarking Configurable Combinator Implementations"
puts "=" * 50
puts

# Benchmark B combinator with configuration switching
puts "B combinator (Bluebird - composition) via ConfigurableBirds:"
Benchmark.ips do |x|
  # Reset to derived
  Smullyan.configuration.use_direct(:b, false)
  
  x.report("B (config: derived)") do
    Smullyan::ConfigurableBirds.B.call(double).call(add_one).call(5)
  end

  # Switch to direct
  Smullyan.configuration.use_direct(:b, true)
  
  x.report("B (config: direct)") do
    Smullyan::ConfigurableBirds.B.call(double).call(add_one).call(5)
  end

  x.compare!
end
puts

# Benchmark all combinators with direct implementation
puts "All combinators with direct implementation enabled:"
Smullyan.configure do |config|
  config.use_all_direct(true)
end

Benchmark.ips do |x|
  x.report("B direct") do
    Smullyan::ConfigurableBirds.B.call(double).call(add_one).call(5)
  end

  x.report("C direct") do
    subtract = ->(x) { ->(y) { x - y } }
    Smullyan::ConfigurableBirds.C.call(subtract).call(10).call(3)
  end

  x.report("W direct") do
    pair = ->(x) { ->(y) { [x, y] } }
    Smullyan::ConfigurableBirds.W.call(pair).call(21)
  end

  x.report("M direct") do
    Smullyan::ConfigurableBirds.M.call(const_42)
  end

  x.report("L direct") do
    Smullyan::ConfigurableBirds.L.call(identity).call(const_42)
  end
end
puts

# Compare configuration overhead
puts "Configuration overhead comparison:"
Smullyan.configuration.use_direct(:b, false)

Benchmark.ips do |x|
  x.report("B via ConfigurableBirds") do
    Smullyan::ConfigurableBirds.B.call(double).call(add_one).call(5)
  end

  x.report("B direct constant") do
    Smullyan::Birds::B.call(double).call(add_one).call(5)
  end

  x.compare!
end

# Reset configuration
Smullyan.reset_configuration!