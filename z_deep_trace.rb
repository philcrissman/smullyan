#!/usr/bin/env ruby
# frozen_string_literal: true

# Deep trace to understand what rec is in the derived Z

require_relative 'lib/smullyan'

b = Smullyan::Birds::B
c = Smullyan::Birds::C
q = Smullyan::Birds::Q
u = Smullyan::Birds::U

puts "DEEP TRACE OF Z = BU(CBQ)"
puts "=" * 70
puts

# Test with a simple function that just inspects what it receives
test_f = lambda { |rec|
  puts ">> f called"
  puts "   rec = #{rec.class}"
  puts "   rec.inspect = #{rec.inspect[0..100]}"

  lambda { |n|
    puts ">> inner lambda called with n=#{n}"

    if n <= 0
      puts "   base case: returning 1"
      1
    else
      puts "   recursive case: n=#{n}"
      puts "   about to call rec.(#{n - 1})"
      puts "   rec is: #{rec.class}"

      begin
        rec_result = rec.(n - 1)
        puts "   rec.(#{n - 1}) returned: #{rec_result.inspect}"
        puts "   rec_result class: #{rec_result.class}"

        # Try to multiply
        result = n * rec_result
        puts "   #{n} * #{rec_result} = #{result}"
        result
      rescue => e
        puts "   ERROR calling rec: #{e.class}: #{e.message}"
        puts "   Trying to inspect what rec.(#{n-1}) actually returned..."

        # Let's see what rec returns without using it
        temp = rec.(n - 1)
        puts "   rec.(#{n-1}) = #{temp.class}"
        puts "   Is it callable? #{temp.respond_to?(:call)}"
        if temp.respond_to?(:call)
          puts "   Let me try calling it..."
          temp2 = temp.(n - 1)
          puts "   Calling it returned: #{temp2.class}"
        end
        raise
      end
    end
  }
}

puts "Building Z from BU(CBQ):"
z_derived = b.(u).(c.(b).(q))
puts "Done"
puts

puts "Applying Z to test_f:"
factorial = z_derived.(test_f)
puts "Got factorial: #{factorial.class}"
puts

puts "Now calling factorial.(2):"
puts "-" * 70
begin
  result = factorial.(2)
  puts "SUCCESS: #{result}"
rescue => e
  puts "FAILED: #{e.message}"
end
puts
puts "=" * 70
puts

# Now let's compare to the direct Z
puts "COMPARISON: Direct Z implementation"
puts "=" * 70
z_direct = ->(f) {
  ->(x) { f.(->(v) { x.(x).(v) }) }.(
    ->(x) { f.(->(v) { x.(x).(v) }) }
  )
}

factorial_direct = z_direct.(test_f)
puts "Calling direct factorial.(2):"
puts "-" * 70
result_direct = factorial_direct.(2)
puts "SUCCESS: #{result_direct}"
