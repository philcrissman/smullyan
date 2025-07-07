# # frozen_string_literal: true

module Smullyan
  module Birds
    # phoenix (or phi) applies takes 4 arguments in total
    # it applies the fourth argument to the 2nd & 3rd, and then
    # applies the results of those to the first
    # phi xyzw = x(yw)(zw)
    Phoenix = B.(B.(S)).(B)

    Phoenix_direct = ->(x) { ->(y) { ->(z) { ->(w) { x.(y.(w)).(z.(w)) }}}}

    Phi = Phoenix
    Φ = Phoenix
  end
end